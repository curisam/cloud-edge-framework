# https://gist.github.com/rchakode/8c362c23876b82c85e997c029b076540

import prometheus_client
import time
import psutil

UPDATE_PERIOD = 300
SYSTEM_USAGE = prometheus_client.Gauge('jpark_system_usage',
                                       'Hold current system resource usage',
                                       ['resource_type'])

if __name__ == '__main__':
    prometheus_client.start_http_server(9001)
  
    while True:
        SYSTEM_USAGE.labels('CPU').set(psutil.cpu_percent())
        SYSTEM_USAGE.labels('Memory').set(psutil.virtual_memory()[2])
        time.sleep(UPDATE_PERIOD)