# EVC Docker Registry 설정


- port 확인

```bash
netstat -tnlp
```

- 특정 port 확인

```bash
netstat -tnlp | grep 8080
```


## docker registry 설정

- evc-registry(docker 레지스트리) 실행

```bash
docker run -d -p 5000:5000 --restart=always --name evc-registry \
-v ./data/registry:/var/lib/registry/Docker/registry/v2 \
registry:latest
```

- docker 레지스트리 컨테이너 내부로 진입 + config 파일 수정

```bash
docker exec -it evc-registry sh

vi /etc/docker/registry/config.yml

```


- config.yml 수정 내용

```bash
...
storage:
  ...
  delete:
    enabled: true
  ...
http:
  ...
  headers:
    ...
    Access-Control-Allow-Origin: ['*']
```


- config.yml 전체 내용 예시

```bash
version: 0.1
log:
  fields:
    service: registry
storage:
  delete:
    enabled: true
  cache:
    blobdescriptor: inmemory
  filesystem:
    rootdirectory: /var/lib/registry
http:
  addr: :5000
  headers:
    X-Content-Type-Options: [nosniff]
    Access-Control-Allow-Origin: ['*']
health:
  storagedriver:
    enabled: true
    interval: 10s
    threshold: 3

```

- docker restart

```bash
sudo  systemctl restart docker
```

- docker registry 서버를 외부에서 접속 가능하도록 포트포워딩 수행 : http://evc.re.kr:20050 로 등록완료

```bash
curl -X GET http://evc.re.kr:20050/v2/_catalog
```

- http://evc.re.kr:20050  docker registry 서버에 임의의 docker 이미지 업로드

```bash
docker tag neo4j localhost:5000/neo4j:test
docker push localhost:5000/neo4j:test
```

- http://evc.re.kr:20050로 부터 docker image를 다운로드 받고자 하는 컴퓨터에서 insecure 설정을 수행

```bash
sudo vi /etc/docker/daemon.json

{
    "insecure-registries": ["evc.re.kr:20050"]
}

```

- http://evc.re.kr:20050로 부터 업로드된 테스트 image 다운로드 테스트

```bash
docker pull evc.re.kr:20050/neo4j:test
```

## Docker registry 시각화 서버 설치 및 연동

- docker registry 시각화 이미지 다운로드 및 실행

```bash
docker pull joxit/docker-registry-ui

docker run -d -p 5001:80 --name registry-ui \
-e REGISTRY_URL=http://evc.re.kr:20050 \
-e DELETE_IMAGES=true \
joxit/docker-registry-ui
```


- 포트포워딩 적용 : http://evc.re.kr:20051/

. 내부 : 5001
. 외부 : 20051









## Docker 핵심 명령어 요약

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
