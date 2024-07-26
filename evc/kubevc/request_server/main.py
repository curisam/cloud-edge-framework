import os
import sys
import pickle
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'
import grpc
from tensorflow_serving.apis import predict_pb2
from tensorflow_serving.apis import prediction_service_pb2_grpc
from tensorflow import make_tensor_proto
from keras.preprocessing.text import Tokenizer
import time
import requests
from fastapi import FastAPI, UploadFile
import numpy as np
from PIL import Image
import cv2
from keras.utils import pad_sequences
import json
from io import BytesIO

app = FastAPI()

K8S_TFS_REST_ADDRESS = "http://192.168.0.110/"
K3S_TFS_REST_ADDRESS = "http://192.168.0.210/"
K8S_TFS_GRPC_ADDRESS = "192.168.0.110"
K3S_TFS_GRPC_ADDRESS = "192.168.0.210"
GRPC_HTTPS = 0
GRPC_PORTS = {
   "mobilenet_v1": 9000,
   "inception_v3": 9001,
   "yolo_v5": 9002,
   "bert_imdb": 9003
}

# 이미지 로드 및 전처리 (for mobilenet)
def run_preprocessing(model_name, raw_data):
    if model_name == "mobilenet_v1":
      image_file_data = Image.open(BytesIO(raw_data))
      image_file_data = image_file_data.resize((224, 224))
      img_array = np.array(image_file_data)
      img_array = img_array.astype('float32') / 255.0
      img_array = np.expand_dims(img_array, axis=0)
      return img_array.tolist()
    if model_name == "inception_v3":
      image_file_data = Image.open(BytesIO(raw_data))
      image_file_data = image_file_data.resize((299, 299))
      img_array = np.array(image_file_data)
      img_array = (img_array - np.mean(img_array)) / np.std(img_array) 
      img_array = img_array.astype(np.float32)
      img_array = np.expand_dims(img_array, axis=0)
      return img_array.tolist()
    if model_name == "yolo_v5":
      np_array = np.frombuffer(raw_data, np.uint8)
      img = cv2.imdecode(np_array, cv2.COLOR_BGR2RGB)
      img = cv2.resize(img, (640, 640))
      img = img.astype('float32') / 255.0
      img = np.expand_dims(img, axis=0)
      return img.tolist()
    if model_name == "bert_imdb":
      tokenizer = Tokenizer()
      tokenizer.fit_on_texts([raw_data])
      input_ids = tokenizer.texts_to_sequences([raw_data])
      input_ids = pad_sequences(input_ids, maxlen=500, padding='post', truncating='post')
      input_masks = [[1] * len(input_ids[0])]
      segment_ids = [[0] * len(input_ids[0])]
      return input_ids, input_masks, segment_ids 

def create_rest_data(model_name, raw_data):
    if model_name == "mobilenet_v1":
      start_preprocess_time = time.time()
      data = json.dumps({"inputs": { "input_1": run_preprocessing("mobilenet_v1", raw_data)}})
      end_preprocess_time = time.time()
      return data, end_preprocess_time - start_preprocess_time
    if model_name == "inception_v3":
      start_preprocess_time = time.time()
      data = json.dumps({"inputs": { "input_3": run_preprocessing("inception_v3", raw_data)}})
      end_preprocess_time = time.time()
      return data, end_preprocess_time - start_preprocess_time
    if model_name == "yolo_v5":
      start_preprocess_time = time.time()
      data = json.dumps({"inputs": { "x": run_preprocessing("yolo_v5", raw_data)}})
      end_preprocess_time = time.time()
      return data, end_preprocess_time - start_preprocess_time
    if model_name == "bert_imdb":
      start_preprocess_time = time.time()
      input_ids, input_masks, segment_ids = run_preprocessing("bert_imdb", raw_data)
      data = json.dumps({"inputs": { "segment_ids": segment_ids, "input_masks": input_masks, "input_ids": input_ids.tolist()}})
      end_preprocess_time = time.time()
      return data, end_preprocess_time - start_preprocess_time

def create_grpc_data(model_name, raw_data):
    if model_name == "mobilenet_v1":
      start_preprocess_time = time.time()
      data = make_tensor_proto(run_preprocessing("mobilenet_v1", raw_data))
      end_preprocess_time = time.time()
      request = predict_pb2.PredictRequest()
      request.model_spec.name = "mobilenet_v1"
      request.model_spec.signature_name = 'serving_default'
      request.inputs['input_1'].CopyFrom(data)
      return request, end_preprocess_time - start_preprocess_time
    if model_name == "inception_v3":
      start_preprocess_time = time.time()
      data = make_tensor_proto(run_preprocessing("inception_v3", raw_data))
      end_preprocess_time = time.time()
      request = predict_pb2.PredictRequest()
      request.model_spec.name = "inception_v3"
      request.model_spec.signature_name = 'serving_default'
      request.inputs['input_3'].CopyFrom(data)
      return request, end_preprocess_time - start_preprocess_time
    if model_name == "yolo_v5":
      start_preprocess_time = time.time()
      data = make_tensor_proto(run_preprocessing("yolo_v5", raw_data))
      end_preprocess_time = time.time()
      request = predict_pb2.PredictRequest()
      request.model_spec.name = "yolo_v5"
      request.model_spec.signature_name = 'serving_default'
      request.inputs['x'].CopyFrom(data)
      return request, end_preprocess_time - start_preprocess_time
    if model_name == "bert_imdb":
      start_preprocess_time = time.time()
      input_ids, input_masks, segment_ids = run_preprocessing("bert_imdb", raw_data)
      end_preprocess_time = time.time()
      request = predict_pb2.PredictRequest()
      request.model_spec.name = "bert_imdb"
      request.model_spec.signature_name = 'serving_default'
      request.inputs['input_ids'].CopyFrom(make_tensor_proto(input_ids, shape=[1, len(input_ids[0])]))
      request.inputs['input_masks'].CopyFrom(make_tensor_proto(input_masks, shape=[1, len(input_masks[0])]))
      request.inputs['segment_ids'].CopyFrom(make_tensor_proto(segment_ids, shape=[1, len(segment_ids[0])]))
      return request, end_preprocess_time - start_preprocess_time

def rest_predict(model_name, data, kubernetes_platform):
    print("REST:")
    # print("  Size of Input : {}".format(round(sys.getsizeof(str(data))/(1024**2),3)))
    print("  Size of Input(Pickle) : {}".format(round(sys.getsizeof(pickle.dumps(data))/(1024**2), 3)))
    if kubernetes_platform == "k8s":
       server_address = K8S_TFS_REST_ADDRESS
    else:
       server_address = K3S_TFS_REST_ADDRESS
    headers = {"content-type": "application/json"}
    url = server_address + f"{model_name}/v1/models/" + model_name + ":predict"
    request_time = time.time()
    response = requests.post(url, data=data, headers=headers)
    response_time = time.time()
    elapsed_time = response_time - request_time
    result = response.text
    # print("  Size of Output :  {}".format(round(sys.getsizeof(str(result))/(1024**2), 20)))
    print("  Size of Output(Pickle) :  {}".format(round(sys.getsizeof(pickle.dumps(result))/(1024**2), 20)))
    return result, elapsed_time

def grpc_predict(stub, request):
    print("gRPC:")
    # print("  Size of Input : {}".format(round(sys.getsizeof(str(request))/(1024**2), 3)))
    print("  Size of Input(Pickle) : {}".format(round(sys.getsizeof(pickle.dumps(request))/(1024**2), 3)))
    request_time = time.time()
    result = stub.Predict(request, timeout=100.0)
    response_time = time.time()
    elapsed_time = response_time - request_time
    # print("  Size of Output :  {}".format(round(sys.getsizeof(str(result))/(1024**2), 20)))
    print("  Size of Output(Pickle) :  {}".format(round(sys.getsizeof(pickle.dumps(result))/(1024**2), 20)))
    return result, elapsed_time

def create_grpc_stub(kubernetes_platform, model_name, use_https):
  if kubernetes_platform == "k8s":
      server_address = f"{K8S_TFS_GRPC_ADDRESS}:{GRPC_PORTS[model_name]}"
  else:
      server_address = f"{K3S_TFS_GRPC_ADDRESS}:{GRPC_PORTS[model_name]}"
  if (use_https):
    channel = grpc.secure_channel(server_address,grpc.ssl_channel_credentials(),options=[('grpc.max_send_message_length', 50 * 1024 * 1024), ('grpc.max_receive_message_length', 50 * 1024 * 1024)])
  else:
    channel = grpc.insecure_channel(server_address,options=[('grpc.max_send_message_length', 50 * 1024 * 1024), ('grpc.max_receive_message_length', 50 * 1024 * 1024)])

  # gRPC 스텁 생성
  stub = prediction_service_pb2_grpc.PredictionServiceStub(channel)
  return stub

@app.get('/')
async def main_page():
   return "Welcome!"

@app.post('/k8s/rest/mobilenet_v1/predict')
async def rest_mobilenet_v1_predict(file: UploadFile):
    image_file = await file.read()
    data, preprocess_time = create_rest_data("mobilenet_v1", image_file)
    start_inference_time = time.time()
    rest_predict("mobilenet_v1", data, "k8s")
    end_inference_time = time.time()
    response = {
       "inference_time": end_inference_time - start_inference_time,
       "preprocess_time": preprocess_time
    }
    return response

@app.post('/k8s/grpc/mobilenet_v1/predict')
async def grpc_mobilenet_v1_predict(file: UploadFile):
    image_file = await file.read()
    request, preprocess_time = create_grpc_data("mobilenet_v1", image_file)
    stub = create_grpc_stub("k8s", "mobilenet_v1", GRPC_HTTPS)
    start_inference_time = time.time()
    result = grpc_predict(stub, request)
    end_inference_time = time.time()
    response = {
       "inference_time": end_inference_time - start_inference_time,
       "preprocess_time": preprocess_time
    }
    return response

@app.post('/k8s/rest/inception_v3/predict')
async def rest_inception_v3_predict(file: UploadFile):
    image_file = await file.read()
    data, preprocess_time = create_rest_data("inception_v3", image_file)
    start_inference_time = time.time()
    rest_predict("inception_v3", data, "k8s")
    end_inference_time = time.time()
    response = {
       "inference_time": end_inference_time - start_inference_time,
       "preprocess_time": preprocess_time
    }
    return response

@app.post('/k8s/grpc/inception_v3/predict')
async def grpc_inception_v3_predict(file: UploadFile):
    image_file = await file.read()
    request, preprocess_time = create_grpc_data("inception_v3", image_file)
    stub = create_grpc_stub("k8s", "inception_v3", GRPC_HTTPS)
    start_inference_time = time.time()
    result = grpc_predict(stub, request)
    end_inference_time = time.time()
    response = {
       "inference_time": end_inference_time - start_inference_time,
       "preprocess_time": preprocess_time
    }
    return response

@app.post('/k8s/rest/yolo_v5/predict')
async def rest_yolo_v5_predict(file: UploadFile):
    image_file = await file.read()
    data, preprocess_time = create_rest_data("yolo_v5", image_file)
    start_inference_time = time.time()
    rest_predict("yolo_v5", data, "k8s")
    end_inference_time = time.time()
    response = {
       "inference_time": end_inference_time - start_inference_time,
       "preprocess_time": preprocess_time
    }
    return response

@app.post('/k8s/grpc/yolo_v5/predict')
async def grpc_yolo_v5_predict(file: UploadFile):
    image_file = await file.read()
    request, preprocess_time = create_grpc_data("yolo_v5", image_file)
    stub = create_grpc_stub("k8s", "yolo_v5", GRPC_HTTPS)
    start_inference_time = time.time()
    result = grpc_predict(stub, request)
    end_inference_time = time.time()
    response = {
       "inference_time": end_inference_time - start_inference_time,
       "preprocess_time": preprocess_time
    }
    return response

@app.post('/k8s/rest/bert_imdb/predict')
async def rest_bert_imdb_predict(text: str = None):
    data, preprocess_time = create_rest_data("bert_imdb", text)
    start_inference_time = time.time()
    rest_predict("bert_imdb", data, "k8s")
    end_inference_time = time.time()
    response = {
       "inference_time": end_inference_time - start_inference_time,
       "preprocess_time": preprocess_time
    }
    return response

@app.post('/k8s/grpc/bert_imdb/predict')
async def grpc_bert_imdb_predict(text: str = None):
    request, preprocess_time = create_grpc_data("bert_imdb", text)
    stub = create_grpc_stub("k8s", "bert_imdb", GRPC_HTTPS)
    start_inference_time = time.time()
    result = grpc_predict(stub, request)
    end_inference_time = time.time()
    response = {
       "inference_time": end_inference_time - start_inference_time,
       "preprocess_time": preprocess_time
    }
    return response

@app.post('/k3s/rest/mobilenet_v1/predict')
async def rest_mobilenet_v1_predict(file: UploadFile):
    image_file = await file.read()
    data, preprocess_time = create_rest_data("mobilenet_v1", image_file)
    start_inference_time = time.time()
    rest_predict("mobilenet_v1", data, "k3s")
    end_inference_time = time.time()
    response = {
       "inference_time": end_inference_time - start_inference_time,
       "preprocess_time": preprocess_time
    }
    return response

@app.post('/k3s/grpc/mobilenet_v1/predict')
async def grpc_mobilenet_v1_predict(file: UploadFile):
    image_file = await file.read()
    request, preprocess_time = create_grpc_data("mobilenet_v1", image_file)
    stub = create_grpc_stub("k3s", "mobilenet_v1", GRPC_HTTPS)
    start_inference_time = time.time()
    result = grpc_predict(stub, request)
    end_inference_time = time.time()
    response = {
       "inference_time": end_inference_time - start_inference_time,
       "preprocess_time": preprocess_time
    }
    return response

@app.post('/k3s/rest/inception_v3/predict')
async def rest_inception_v3_predict(file: UploadFile):
    image_file = await file.read()
    data, preprocess_time = create_rest_data("inception_v3", image_file)
    start_inference_time = time.time()
    rest_predict("inception_v3", data, "k3s")
    end_inference_time = time.time()
    response = {
       "inference_time": end_inference_time - start_inference_time,
       "preprocess_time": preprocess_time
    }
    return response

@app.post('/k3s/grpc/inception_v3/predict')
async def grpc_inception_v3_predict(file: UploadFile):
    image_file = await file.read()
    request, preprocess_time = create_grpc_data("inception_v3", image_file)
    stub = create_grpc_stub("k3s", "inception_v3", GRPC_HTTPS)
    start_inference_time = time.time()
    result = grpc_predict(stub, request)
    end_inference_time = time.time()
    response = {
       "inference_time": end_inference_time - start_inference_time,
       "preprocess_time": preprocess_time
    }
    return response

@app.post('/k3s/rest/yolo_v5/predict')
async def rest_yolo_v5_predict(file: UploadFile):
    image_file = await file.read()
    data, preprocess_time = create_rest_data("yolo_v5", image_file)
    start_inference_time = time.time()
    rest_predict("yolo_v5", data, "k3s")
    end_inference_time = time.time()
    response = {
       "inference_time": end_inference_time - start_inference_time,
       "preprocess_time": preprocess_time
    }
    return response

@app.post('/k3s/grpc/yolo_v5/predict')
async def grpc_yolo_v5_predict(file: UploadFile):
    image_file = await file.read()
    request, preprocess_time = create_grpc_data("yolo_v5", image_file)
    stub = create_grpc_stub("k3s", "yolo_v5", GRPC_HTTPS)
    start_inference_time = time.time()
    result = grpc_predict(stub, request)
    end_inference_time = time.time()
    response = {
       "inference_time": end_inference_time - start_inference_time,
       "preprocess_time": preprocess_time
    }
    return response

@app.post('/k3s/rest/bert_imdb/predict')
async def rest_bert_imdb_predict(text: str = None):
    data, preprocess_time = create_rest_data("bert_imdb", text)
    start_inference_time = time.time()
    rest_predict("bert_imdb", data, "k3s")
    end_inference_time = time.time()
    response = {
       "inference_time": end_inference_time - start_inference_time,
       "preprocess_time": preprocess_time
    }
    return response

@app.post('/k3s/grpc/bert_imdb/predict')
async def grpc_bert_imdb_predict(text: str = None):
    request, preprocess_time = create_grpc_data("bert_imdb", text)
    stub = create_grpc_stub("k3s", "bert_imdb", GRPC_HTTPS)
    start_inference_time = time.time()
    result = grpc_predict(stub, request)
    end_inference_time = time.time()
    response = {
       "inference_time": end_inference_time - start_inference_time,
       "preprocess_time": preprocess_time
    }
    return response

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)