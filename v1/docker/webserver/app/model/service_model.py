from flask import current_app
from kubernetes import client
from kubernetes.client.exceptions import ApiException

current_count = 0

def get_status():
    global current_count
    if current_count < current_app.config['RUNNING_COUNT']: 
        current_count += 1
        return "running"
    else: 
        return "waiting"    

def start_service():
    global current_count
    current_count = 0 
    
    return "starting"



