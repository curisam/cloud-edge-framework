### Test example
```bash
curl -X POST http://ip:port/grpc/yolo_v5/predict \
-H "Content-Type: multipart/form-data" \
-F "file=@y.jpg;type=image/jpeg"
```

```bash
curl -X POST http://ip:port/grpc/bert_imdb/predict?text="test"
```
