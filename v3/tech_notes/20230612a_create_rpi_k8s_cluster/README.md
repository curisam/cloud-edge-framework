-----------------------------------------------------
# 연구노트 
 - 기술문서명 : RaspberryPI 4b, 8GB에 k8s cluster 설치하기
 - 과제명 : 능동적 즉시 대응 및 빠른 학습이 가능한 적응형 경량 엣지 연동분석 기술개발
 - 영문과제명 : Development of Adaptive and Lightweight Edge-Collaborative Analysis Technology for Enabling Proactively Immediate Response and Rapid Learning
 - Acknowledgement : This work was supported by Institute of Information & communications Technology Planning & Evaluation (IITP) grant funded by the Korea government(MSIT) (No. 2021-0-00907, Development of Adaptive and Lightweight Edge-Collaborative Analysis Technology for Enabling Proactively Immediate Response and Rapid Learning).
 - 작성자 : 박종빈
 
 - 날짜 : 2023-06-12
 - 연구자 : 박종빈
-----------------------------------------------------

## 개요

- 컨네이너화된 워크로드와 서비스를 관리하기 위한 도구로 k8s(kubernetes)가 존재합니다.
- 본 연구에서는 라즈베리파이 초경량 에지 디바이스를 이용하여 k8s 클러스터를 구축하는 방법을 정리합니다.
- 설치 절차는 향후 스크립트를 실행하여 자동 처리하는 것이 바람직합니다.


## 참고 문헌

- 본 연구 및 문서 작성은 아래의 링크들을 참고하여 진행했습니다.
- https://jussiroine.com/2021/06/building-a-kubernetes-cluster-using-raspberry-pi-4/
- https://www.youngju.dev/blog/202212/raspberrypi_kubernetes_install



## 목표

- 6대의 라즈베리파이(Raspberry pi, rpi)가 있습니다.
- 1번 rpi 는 master node로 동작하고, 나머지 2 ~ 6번 rpi는 worker node로 동작합니다.



## 설치 순서

### 1. 그룹 설정

- Ubuntu 64bit OS가 설치된 라즈베리파이 6대를 준비합니다(수량은 변경 및 확장될 수 있습니다).
- 준비된 라즈베리파이는 동일 네트워크에 존재함을 가정합니다.
- 각각 라즈베리파이 다바이스에서 /boot/cmdline.txt 파일을 열어 첫줄 맨 뒤에, "cgroup_memory=1 cgroup_enable=memory" 내용을 추가후 reboot합니다.


- 즉, 아래와 같이 파일을 변경합니다.

```bash

$ sudo vi /boot/cmdline.txt

  cgroup_memory=1 cgroup_enable=memory

```

- 변경된 '/boot/cmdline.txt' 파일은 아래와 같습니다.

```bash
console=serial0,115200 console=tty1 root=PARTUUID=c8d8ee5a-02 rootfstype=ext4 fsck.repair=yes rootwait quiet splash plymouth.ignore-serial-consoles cgroup_memory=1 cgroup_enable=memory
```

- 리부팅하여 설정을 적용합니다.

```bash

$ sudo reboot

```

- 앞서의 과정을 수행하지 않으면 Master node 및 Worker node에서 프로그램 설치시 오류가 발생할 수 있습니다.



### 2. Master node 설정


- 설치 스크립트를 수행합니다.

```bash

$ curl -sfL https://get.k3s.io | sh -

```

- 마스터 노드의 토큰을 읽은 후 이를 소정의 장소에 보관합니다.

```bash

$ sudo cat  /var/lib/rancher/k3s/server/node-token

```

- 예를들어 아래와 같은 토큰이 출력되었습니다.

```bash
K102ae5a6cfc0634f30e6d6a7d0ef5cd9c19f098dd795fe164ff5878ee71b4b8c63::server:a4947c7a5e2cf637fcebdc73ffacffdf
```





## 연구 내용

- Port 방화벽 처리 (8000번 포트를 여는 예시)

```bash
$ sudo iptables -I INPUT -p tcp --dport 8000 -j ACCEPT
$ sudo iptables -I OUTPUT -p tcp --sport 8000 -j ACCEPT
```
