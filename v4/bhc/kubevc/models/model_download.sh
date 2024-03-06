#!/bin/bash

# image classification TF/FP32 model (mobilenet v1)
# Unzip must be installed.
cd ./mobilenet_v1
curl -O https://edge-inference.s3.us-west-2.amazonaws.com/CNN/model/mobilenet_v1/mobilenet_v1.zip
unzip -q mobilenet_v1.zip && rm mobilenet_v1.zip
mkdir -p ./mobilenet_v1/1
mv ./mobilenet_v1/* ./mobilenet_v1/1
cd ..

cd ./inception_v3
curl -O https://edge-inference.s3.us-west-2.amazonaws.com/CNN/model/inception_v3/inception_v3.zip
unzip -q inception_v3.zip && rm inception_v3.zip
mkdir -p ./inception_v3/1
mv ./inception_v3/* ./inception_v3/1
cd ..

#object detection TF/FP32 model (yolo v5)
cd ./yolo_v5
curl -O https://edge-inference.s3.us-west-2.amazonaws.com/CNN/model/yolo_v5/yolo_v5.zip
unzip -q yolo_v5.zip && rm yolo_v5.zip
mv yolov5/yolov5s_saved_model yolo_v5
mkdir -p ./yolo_v5/1
mv ./yolo_v5/* ./yolo_v5/1
rm -rf yolov5
cd ..

#bert imdb model
cd ./bert_imdb
curl -O https://edge-inference.s3.us-west-2.amazonaws.com/NLP/bert_imdb.zip
unzip -q bert_imdb.zip && rm bert_imdb.zip
mkdir -p ./bert_imdb/1
mv ./bert_imdb/* ./bert_imdb/1