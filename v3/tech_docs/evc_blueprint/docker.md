# Docker

- port 확인

```bash
netstat -tnlp
```

- 특정 port 확인

```bash
netstat -tnlp | grep 8080
```




## Docker 핵심 명령어

- docker 이미지 확인

```bash
docker images
```

- docker 이미지 삭제

```bash
# docker rmi IMAGE[:TAG]
docker rmi ubuntu:20.04
```


- docker 컨테이너 목록 확인 (가동 중인 컨테이너만 표시)

```bash
docker ps
```

- docker 컨테이너 목록 확인 (가동 중지된 컨테이너까지 표시)

```bash
docker ps -a
```


- 중지된 컨테이너 실행

```bash

```

- 컨테이너 재시작 및 연결


- 컨테이너 삭제

```bash
docker rm my_ubuntu
```

- 컨테이너 정지 + 삭제

```bash
docker rm -f my_ubuntu 
```

- 컨테이너 분석

```bash
docker inspect my_ubuntu
```

- docker hub에서 컨테이너 이미지 다운로드

```bash
# docker pull nginx:latest
```

- docker 컨테이너 실행

```bash
# docker run -i -t ubuntu:20.04 /bin/bash
```

- 데몬으로 실행
```bash
# docker run -d -p 80:80 nginx
```

- 컨테이너 이름 할당
```bash
# docker run -i -t --name my_ubuntu ubuntu:20.04 /bin/bash
```

- 컨테이너 포트포워딩 
```bash
# docker run -d --name my_nginx -p 80:80 -p 3306:3306 nginx:latest
```


- docker

- docker registry browser

```bash
docker pull klausmeyer/docker-registry-browser
```




