# Grafana 설치  


- 참고주소 : https://grafana.com/

## Ubuntu 20.04 LTS에서 apt-get을 이용한 설치 방법

- 아래 주소 참고하여 진행
```bash
    https://computingforgeeks.com/how-to-install-grafana-on-ubuntu-linux-2/
```

- 방화벽 열기

```bash
    $ sudo iptables -I INPUT 1 -p tcp --dport 3000 -j ACCEPT
```

## docker를 이용한 설치

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


