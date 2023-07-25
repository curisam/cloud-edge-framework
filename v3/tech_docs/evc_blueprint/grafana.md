# Grafana 설치  


## Ubuntu 20.04 LTS에서 apt-get을 이용한 설치 방법

- 참고주소 1 : https://grafana.com/
- 참고주소 2 : https://grafana.com/docs/grafana/latest/setup-grafana/installation/debian/

- 설치 버전 : Grafana OSS (free version)

```bash

sudo apt-get install -y apt-transport-https
sudo apt-get install -y software-properties-common wget
sudo wget -q -O /usr/share/keyrings/grafana.key https://apt.grafana.com/gpg.key

echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

# echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list


# Update the list of available packages
sudo apt-get update

# Install the latest OSS release:
sudo apt-get install grafana

# Chage port or other parameters : (주의) 그라파나에서는 세미콜론(;)이 주석을 의미함 
sudo vi /etc/grafana/grafana.ini

# Start server
sudo grafana server

```


- backgroud 실행

```bash 

nohup sudo grafana server &

```


## docker를 이용한 설치

- 방화벽 열기

```bash
    $ sudo iptables -I INPUT 1 -p tcp --dport 3000 -j ACCEPT
```

- 참고 : https://computingforgeeks.com/how-to-install-grafana-on-ubuntu-linux-2/

- 아래 주소 문서를 참고하여 Grafana opensource version을 설치합니다.

```bash
https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/
```

- Grafana grafana/grafana-oss 설치 방법

```bash
docker run -d -p 3000:3000 grafana/grafana-oss
```

- 기본 접속 정보

```bash
    기본 포트: 3000
    기본 ID: admin
    기본 PW: admin
```



## Grafana 사용팁

### iframe 으로 웹페이지 넣기

- grafana.ini 파일을 열기 
```bash
$ sudo vi /etc/grafana/grafana.ini
```

- 아래와 같이 편집하기 

```
allow_embedding = true
disable_sanitize_html = true

[auth.anonymous]
enabled = true
org_name = Main Org
org_role = Viewer
```

- 서비스 재시작 하기 (Ubuntu의 경우)

```bash
$ sudo systemctl restart grafana-server
```


- 서비스 동작상태 확인하기 (Ubuntu의 경우)

```bash
$ sudo systemctl status grafana-server
```

- 그라파나 HTML UI / 방패 아이콘 / Settings / "allow_embedding" 찾기

- allow_embedding 이 true인지 확인 


### 콘솔 명령어로 플러그인 설치하기

- 예를들어, diagram, ajax 플러그인 설치시

```bash
    $ grafana-cli plugins install jdbranham-diagram-panel # DIAGRAM
    $ grafana-cli plugins install ryantxu-ajax-panel # AJAX
    $ grafana-cli plugins install marcusolsson-csv-datasource # CSV

    grafana-cli plugins install innius-video-panel # Video
```

```bash
    $ sudo systemctl restart grafana-server
    $ sudo systemctl status grafana-server
```






### Grafana 설치  


- 참고주소 : https://grafana.com/

#### Ubuntu 20.04 LTS에서 apt-get을 이용한 설치 방법

- 아래 주소 참고하여 진행
```bash
    https://computingforgeeks.com/how-to-install-grafana-on-ubuntu-linux-2/
```

- 방화벽 열기

```bash
    $ sudo iptables -I INPUT 1 -p tcp --dport 3000 -j ACCEPT
```

#### docker를 이용한 설치

- 아래 주소 문서를 참고하여 Grafana opensource version을 설치합니다.

```bash
https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/
```

- Grafana grafana/grafana-oss 설치 방법

```bash
docker run -d -p 3000:3000 grafana/grafana-oss
```

- 기본 접속 정보

```bash
    기본 포트: 3000
    기본 ID: admin
    기본 PW: admin
```

#### Grafana 사용팁

##### iframe 으로 웹페이지 넣기

- grafana.ini 파일을 열기 
```bash
$ sudo vi /etc/grafana/grafana.ini
```

- 아래와 같이 편집하기 

```
allow_embedding = true
disable_sanitize_html = true

[auth.anonymous]
enabled = true
org_name = Main Org
org_role = Viewer
```

- 서비스 재시작 하기 (Ubuntu의 경우)

```bash
$ sudo systemctl restart grafana-server
```


- 서비스 동작상태 확인하기 (Ubuntu의 경우)

```bash
$ sudo systemctl status grafana-server
```

- 그라파나 HTML UI / 방패 아이콘 / Settings / "allow_embedding" 찾기

- allow_embedding 이 true인지 확인 


##### 콘솔 명령어로 플러그인 설치하기

- 예를들어, diagram, ajax 플러그인 설치시

```bash
    $ grafana-cli plugins install jdbranham-diagram-panel # DIAGRAM
    $ grafana-cli plugins install ryantxu-ajax-panel # AJAX
    $ grafana-cli plugins install marcusolsson-csv-datasource # CSV

    grafana-cli plugins install innius-video-panel # Video
```

```bash
    $ sudo systemctl restart grafana-server
    $ sudo systemctl status grafana-server
```
