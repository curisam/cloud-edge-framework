from flask import Flask
from prometheus_client import make_wsgi_app, Counter
from prometheus_client.core import REGISTRY, GaugeMetricFamily
from wsgiref.simple_server import make_server
import threading
import time

app = Flask(__name__)

REQUESTS = Counter('requests_total', 'Total HTTP requests.')
CPU_USAGE = GaugeMetricFamily('cpu_usage_percent', 'CPU usage percent', labels=['host'])
MEMORY_USAGE = GaugeMetricFamily('memory_usage_percent', 'Memory usage percent', labels=['host'])
DISK_USAGE = GaugeMetricFamily('disk_usage_percent', 'Disk usage percent', labels=['host'])

class MetricsResource(object):
    def __init__(self):
        pass

    def collect(self):
        cpu_percent = psutil.cpu_percent()
        mem_info = psutil.virtual_memory()
        disk_usage = psutil.disk_usage("/")
        yield CPU_USAGE.add_metric(["localhost"], cpu_percent)
        yield MEMORY_USAGE.add_metric(["localhost"], mem_info.percent)
        yield DISK_USAGE.add_metric(["localhost"], disk_usage.percent)

def get_prometheus_metrics():
    while True:
        time.sleep(10)
        CPU_USAGE.samples = []
        MEMORY_USAGE.samples = []
        DISK_USAGE.samples = []

@app.route('/')
def hello_world():
    REQUESTS.inc()
    return 'Hello, World!'

if __name__ == '__main__':
    app.wsgi_app = make_wsgi_app(REGISTRY)
    threading.Thread(target=get_prometheus_metrics).start()
    httpd = make_server('', 8080, app)
    httpd.serve_forever()
