# Visulaization Server (Ubuntu)

- Demo : http://ketiabcs.iptime.org:39080


## apt-get 으로 설치 및 실행

- 참고 : https://grafana.com/docs/grafana/latest/setup-grafana/installation/debian/


### Install

```bash
$ sudo apt update
$ sudo apt -y install grafana
```

### Start

```bash
sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl status grafana-server
```

or

```
sudo systemctl enable --now grafana-server
systemctl status grafana-server.service 
```

### Install Plugins

https://grafana.com/grafana/plugins/frser-sqlite-datasource/

```bash
grafana-cli plugins install frser-sqlite-datasource

```

### (옵션) 방화벽 이슈 (ufw 사용시)

```bash
sudo apt -y install ufw
sudo ufw enable
sudo ufw allow ssh
sudo ufw allow 3000/tcp
```



## Docker 기반 실행

- 아래의 도커 허브 문서를 참고합니다.

```bash
    https://hub.docker.com/r/grafana/grafana
```

- 아래와 같이 실행합니다.

```bash
    $ docker run -d --name=grafana -p 3000:3000 grafana/grafana
```


- 하지만 위와 같이 실행하면 dashboard가 로딩되거나 저장되지 않습니다.

```bash
version: "3"
services:
  grafana:
    image: grafana/grafana-oss
    container_name: grafana
    ports:
      - 3000:3000
    volumes:
      - grafana-storage:/var/lib/grafana
    restart: always
volumes:
  grafana-storage:
```


## Install Plugins

- Example

```bash
    $ grafana-cli plugins install corpglory-progresslist-panel
```

```bash
    $ docker run -d --name grafana -p 3000:3000 -v grafana-storage:/var/lib/grafana cognite/grafana-cdf
```

grafana-diagram


### grafana datasource

- 연동 테스트

![grafana_data_source](./img4doc/grafana_data_source.png)


