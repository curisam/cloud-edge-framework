from ultralytics import YOLO

model = YOLO("yolov8s.pt")  
model.train(data="total.yaml", epochs=10, batch=16)  # train the model
model.val() 

# batch = 16 # 1%당 1.8분 