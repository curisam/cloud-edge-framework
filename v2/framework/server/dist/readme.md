# Ansible을 이용한 배포/관리 기술 개요

## 작성

- by : JPark @ KETI
- since : 2022-06-08

## 개요
- 본, 문서에서는 Ansible을 이용한 배포/관리 기술의 개요를 기술합니다.




# 내용

## 설치

- Python 환경
```bash
$ pip install ansible
# 설치 할 앤서블 버전 설정
$ pip install ansible==2.10.7
```

- Ubuntu Linux
```bash
$ sudo apt install ansible
```

- MacOS
```bash
$ brew install ansible
```

## SSH 연결 사전 설정

### 절차

- 단계 1. ssh-keygen으로 키를 생성하고,
- 단계 2. ssh-copy-id로 키를 추가합니다.

### 예시

- 동일 네트워크에 2대의 컴퓨터 {A, B}가 있다고 가정합니다.
- A 는 "192.168.1.5" IP를 갖는다고 하고,
- B 는 "192.168.1.3" IP를 갖는다고 가정합니다.
- B 의 사용자 id는 "jpark"이라고 가정합니다.

- A에서 ssh-keygen으로 먼저 키를 생성합니다.
```bash
$ ssh-keygen -t rsa
```

- A에서 생성한 공개키를 B로 전송합니다.
```bash
$ ssh-copy-id jpark@192.168.1.3
```
![ssh-copy-id](img4doc/ssh-copy-id.png)

- A에서 B로 접속합니다.

```bash
$ ssh jpark@192.168.1.3
```
![ssh](img4doc/ssh-connection.png)


## Ansible 사용해보기

### 절차

- Ansible 이 설치되어 있는지 확인합니다.

```bash
$ ansible --version
```
![ansible-version](img4doc/ansible-version.png)


- server.ini 파일을 만듭니다.

```bash
$ vi server.ini
```

- server.ini 파일에 서버 목록을 기입합니다.
- 아래 예시에서는 192.168.1.3 은 존재하는 서버지만, 192.168.1.7 은 존재하지 않는 서버입니다.

```bash
[server]
192.168.1.3
192.168.1.7
```

- 터미널에서 ansible을 통해 ping을 실행합니다.

```bash
ansible server -i server.ini -m ping
```

![ansible-ping](img4doc/ansible-ping.png)


- ansible을 통해 ping을 실행시에 사용자 명을 옵션으로 줄 수 있습니다.

```bash
ansible server -i server.ini -m ping -jpark
```

