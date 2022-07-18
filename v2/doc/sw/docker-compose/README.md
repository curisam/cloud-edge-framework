# Docker-compose

- 다수의 컨테이너를 함께 운용하고 관리하고자 할 때 사용하는 도구

## 기본 사용법

- docker-compose.yml 파일 작성 

- 실행하기 1 : 같은 폴더에 docker-compose.yml 파일 있을 때

```bash
    $ docker-compose up
```

- 실행하기 2 : docker-compose.yml 파일의 경로 알려주기

```bash
    $ docker-compose -f /path/docker-compose.yml up
```

- "docker-compose up" 명령어를 실행하면, "docker-compose.yml" 파일에 존재하는 여러 개의 컨테이너들이 함께 생성됩니다.


## 기본 명령어

- 'up' : 컨테이너 생성 및 시작

```bach
    $ docker-compose up
```

- 'ps' : 컨테이너 목록 표시
- 'logs' : 컨테이너 로그 출력
- 'run' : 컨테이너 실행하기
- 'start' : 컨테이너 시작하기
- 'stop' : 컨테이너 멈추기
- 'restart' : 컨테이너 재시작하기
- 'pause' : 컨테이너 일시 정지하기
- 'unpause' : 컨테이너 다시 진행하기
- 'port' : 컨테이너 공개된 포트 번호 표시하기
- 'config' : config 확인하기
- 'kill' : 컨테이너 강제로 중지하기
- 'rm' : 컨테이너 삭제하기
- 'down' : 컨테이너 리소스 삭제하기

https://velog.io/@swhan9404/Nginx%EB%A1%9C-%EA%B0%99%EC%9D%80-%EB%8F%84%EB%A9%94%EC%9D%B8%EC%97%90-prometheus-alertmanager-grafana-%EB%9D%84%EC%9A%B0%EA%B8%B0