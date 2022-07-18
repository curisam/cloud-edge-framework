# Docker-swarm

- 분산된 물리적 컴퓨터들에게 컨테이너를 배포하고 관리하는 도구
- 쿠버네티스보다는 기능 제한이 있으나 간단함


## 기본 사용법

- 도커 스웜 모드 초기화 (IP 주소 설정)

```bash
    $ docker swarm init --advertise-addr 192.168.0.154
```

- 스웜 상태 조회

```bash
    $ docker info | grep Swarm
```

- edge node가 manager node에게 접근하기 위한 IP 입력

```bash

```

docker swarm join --token SWMTKN-1-3k5r45mfx71b0qhaoz2n3l5szwp9qckhwtg4rhb0gz36pmtouy-3pw79vsk11htl7sq8kcasfa29 192.168.0.154:2377



## 기본 명령어
