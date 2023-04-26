from fastapi import FastAPI
from prometheus_fastapi_instrumentator import Instrumentator
import psutil
import requests

app = FastAPI()
Instrumentator().instrument(app).expose(app)

#prometheus_url = "http://<prometheus_server>:<prometheus_port>/metrics/job/<job_name>"
prometheus_url = "http://0.0.0.0:9090/api/v1/query"

@app.get("/")
async def root():
    cpu_percent = psutil.cpu_percent()
    mem_info = psutil.virtual_memory()
    disk_usage = psutil.disk_usage("/")
    requests.post(prometheus_url, data=f'cpu_usage_percent {cpu_percent}')
    requests.post(prometheus_url, data=f'memory_usage_percent {mem_info.percent}')
    requests.post(prometheus_url, data=f'disk_usage_percent {disk_usage.percent}')
    return {"message": "Hello World"}

