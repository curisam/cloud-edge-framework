#import uvicorn

# main.py
from fastapi import FastAPI
from flask import Flask, request, jsonify

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/items/{item_id}")
def read_item(item_id: int, q: str = None):
    return {"item_id": item_id, "q": q}

@app.route('/data', methods=['POST'])
def receive_data():
    data = request.get_json()
    data_store.append(data)
    return jsonify(success=True)
