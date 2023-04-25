import subprocess
import sqlite3

def get_cpu_usage():
    """
    Get CPU usage percentage
    """
    output = subprocess.check_output("top -bn1 | grep 'Cpu(s)' | awk '{print $2+$4}'", shell=True)
    cpu_usage = float(output.decode().strip())
    return cpu_usage

def get_cpu_temperature():
    """
    Get system temperature
    """
    output = subprocess.check_output("sensors | grep 'Core 0' | awk '{print $3}'", shell=True)
    temperature = float(output.decode().replace("+", "").replace("°C\n", "").strip())
    return temperature

def get_gpu_temperature():
    result = subprocess.run(['nvidia-smi', '--query-gpu=temperature.gpu', '--format=csv,noheader'], stdout=subprocess.PIPE)
    temperature = result.stdout.decode('utf-8').strip()
    return float(temperature)

def get_gpu_usage():
    result = subprocess.run(['nvidia-smi', '--query-gpu=utilization.gpu', '--format=csv,noheader'], stdout=subprocess.PIPE)
    usage = result.stdout.decode('utf-8').strip()
    return float(usage[:-1])

def save_data(cpu_temperature, cpu_usage, gpu_temperature, gpu_usage):
    """
    Save data to SQLite database
    """
    conn = sqlite3.connect('monitoring.db')
    c = conn.cursor()
    c.execute("INSERT INTO data (cpu_temperature, cpu_usage, gpu_temperature, gpu_usage) VALUES (?, ?, ?, ?)", (cpu_temperature, cpu_usage, gpu_temperature, gpu_usage))
    conn.commit()
    conn.close()
    
import time


# 1초마다 데이터 저장
for i in range(10):
    cpu_temperature = get_cpu_temperature()
    cpu_usage = get_cpu_usage()
    
    gpu_temperature = get_gpu_temperature()
    gpu_usage = get_gpu_usage()
    
    save_data(cpu_temperature, cpu_usage, gpu_temperature, gpu_usage)
    time.sleep(1)
    
    print(f"cpu_temperature('C):{cpu_temperature}, cpu_usage(%):{cpu_usage}")
    print(f"gpu_temperature('C):{gpu_temperature}, gpu_usage(%):{gpu_usage}")
    print("")
