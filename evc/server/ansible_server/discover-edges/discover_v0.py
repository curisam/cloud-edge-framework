import subprocess
import time
import re

# 감지된 에지 장치가 호스트 파일에 이미 존재하는지 확인
def edge_exists(edge_ip):
    with open("hosts", "r") as f:
        hosts = f.read()
    return edge_ip in hosts

# 새로운 에지 장치를 호스트 파일에 추가
def add_edge_to_hosts(edge_ip, edge_name):
    print(f"Adding {edge_ip} to hosts")
    with open("hosts", "a") as f:
        f.write(f"{edge_ip} {edge_name}\n")

# 에지 장치를 감지하고 처리
def discover_edges():
    result = subprocess.run(
        ["avahi-browse", "-r", "_workstation._tcp", "--terminate"],
        capture_output=True,
        text=True
    )
    print('-'*50)
    print(result)
    print('-'*50)
    
    lines = result.stdout.splitlines()
    edge_info = {}
    current_edge = None

    
    #print('-'*50)
    #for line in lines:
    #    print("__", line, "\n")
    #print('-'*50)
    
    return
    
    # Step 1
    for line in lines:
        print('line = ', line)
        
        if "evc_edge" in line:
            parts = line.split()
            print('parts = ', parts)
            if len(parts) > 3:
                IPv4 = parts[2]  # IPv4 찾기
                print('current_edge = ', parts[3])
                edge_info[current_edge] = {}
                print(edge_info)
        
        if "hostname" in line and current_edge:
            match = re.search(r"hostname = \[(.*?)\]", line)
            if match:
                edge_info[current_edge]["hostname"] = match.group(1).split('.')[0]
                edge_name = edge_info[current_edge]["hostname"]
                print('edge_name = ', edge_name)
        if "address" in line and current_edge:
            match = re.search(r"address = \[(.*?)\]", line)
            if match:
                edge_info[current_edge]["ip"] = match.group(1)

    # Step 2
    for _, info in edge_info.items():
        #print(f'edge_name = {edge_name}')
        if "ip" in info:
            edge_ip = info["ip"]
            #print('edge_ip = ', edge_ip)
            if re.match(r"^\d{1,3}(\.\d{1,3}){3}$", edge_ip):
                if not edge_exists(edge_ip):
                    add_edge_to_hosts(edge_ip, info["hostname"])
                else:
                    print(f"Already exist : {edge_ip}, {edge_name}")
            else:
                pass
                #print(f"Invalid IP address: {edge_ip}")
        else:
            print(f"IP address for {edge_name} not found")

# 주기적으로 네트워크를 스캔합니다.
while True:
    discover_edges()
    time.sleep(1)