# Ansible 환경 구축

- 시스템 환경 : Ubuntu
- 설치 내용 : Ansible

## 용어

### Ansible

- Ansible은 인프라스트럭처 자동화를 위한 오픈 소스 IT 자동화 도구로, 서버 설정, 배포, 관리 등을 자동화합니다.

### Playbooks
- Ansible 기본 단위이며, 자동화할 작업 리스트입니다.
- playbooks는 통상적으로 YAML(야믈) 파일로 작성합니다.
- YAML 파일은 배열과 딕셔너리를 텍스트 문서로 정리한 것으로 생각하면 이해가 쉽습니다.


### Control node
- Ansible이 설치된 장치를 말합니다.
- 등록된 여러 노드를 관리합니다.



### Managed nodes
- Control node의 통제를 받는 장치입니다.
- 호스트라고도 부르며, 별도의 애이전트를 설치하지 않아도 됩니다.



### Inventory
- Control node가 관리하고자 하는 노드의 목록입니다.
- 자동화할 기기들을 포함합니다.



### Task
- 기본 작업 단위로써 주로 Ansiable Playbook에 포함됩니다.



### Project
- Playbook YAML 파일이 물리적으로 위치하는 Repository를 뜻합니다.



## 설치

### OpenJDK 17 설치

- openjdk 버전 17 설치 (Ansible 버전에 따라 openjdk 버전은 달라질 수 있습니다) 
- (참고) https://www.linuxcapable.com/how-to-install-openjdk-17-on-ubuntu-linux/


```bash
sudo apt update && sudo apt upgrade
apt-cache search openjdk | grep openjdk-17
sudo apt install openjdk-17-jre
sudo apt install openjdk-17-jdk
java --version

```

- 참고 : 설치된 openjdk 제거

```bash
sudo apt remove openjdk-17-jre openjdk-17-jdk --purge
```


### Ansible Stack 설치

- 참고주소 : https://ansible.readthedocs.io/projects/rulebook/en/latest/installation.html

```bash
pip install ansible-rulebook ansible ansible-runner
```

### 설치 Test

```bash
ansible-rulebook --help
ansible-rulebook --version

```

### Ansible rulebook 사용예시

- 참고 : https://www.thonis.fr/en/posts/ansible-rulebook/

#### 간단한 Hello world

- inventory.yml

```yaml
all:
  hosts:
    localhost:
      ansible_connection: local
```

- rulebook.yml

```yaml
- name: Hello Events
  hosts: localhost
  sources:
    - ansible.eda.range:
        limit: 5
  rules:
    - name: Say Hello
      condition: event.i == 1
      action:
        run_playbook:
          name: ansible.eda.hello
```


- 01_hello_rulebook.sh

```bash
ansible-rulebook -i inventory.yml --rulebook hello_rulebook.yml --verbose
```


- 이 예에서는 sources : 1~5까지 반복함
- condition : 값이 1인 경우
- action : ansible.eda.hello



#### webhook


- 02_webhook_rulebook.sh

```bash
ansible-rulebook -i inventory.yml --rulebook hello_rulebook.yml --verbose
```


- 이 예에서는 sources : 1~5까지 반복함
- condition : 값이 1인 경우
- action : ansible.eda.hello


### Ansible playbook 사용 예시

- 참고문헌 : https://www.cherryservers.com/blog/how-to-run-remote-commands-with-ansible-shell-module#run-ansible-ad-hoc-shell-commands



### Ansible Tower, Semaphore, AWX

- (참고) https://lifeplan-b.tistory.com/144

- Ansible Tower는 Ansible의 UI 기능을 제공하는 상용 기술입니다.
- 이를 공개소스화 한 것이 Ansible Semaphore와 Ansible AWX 입니다.
- 


#### Ansible Tower

- Ansible Tower는 Ansible을 사용한 자동화 작업의 관리 및 오케스트레이션을 제공하는 Redhat의 상용 제품입니다. 

- Ansible Tower는 Ansible을 사용하는 조직이 작업을 중앙에서 관리하고 조정할 수 있도록 도와줍니다.

- 구체적으로는 Ansible을 기반으로 한 자동화 작업의 중앙 집중 관리와 보안, 확장성, 감사 및 보고 기능을 제공하여 효율적인 인프라스트럭처 자동화를 도와줍니다.

- Ansible Tower의 주요 기능은 다음과 같습니다

  1. 웹 기반 대시보드: Ansible Tower는 사용자들에게 직관적이고 사용하기 쉬운 웹 기반 대시보드를 제공합니다. 이를 통해 작업 관리, 일정 관리, 작업 템플릿 등을 관리할 수 있습니다.

  2. 롤 기반 액세스 제어: Ansible Tower는 사용자 및 팀에 대한 액세스 제어를 제공합니다. 롤 기반의 액세스 제어를 사용하여 작업을 할당하고, 사용자 및 그룹별로 권한을 제어할 수 있습니다.

  3. 작업 관리: Ansible Tower를 사용하면 Ansible 작업을 중앙에서 관리하고 실행할 수 있습니다. 작업을 예약하고, 로그 및 보고서를 확인하며, 작업의 성공 여부를 모니터링할 수 있습니다.

  4. 스케일 업 및 하이브리드 환경: Ansible Tower는 큰 규모의 인프라스트럭처에 대한 확장성을 제공합니다. 다중 플레이북 실행, 병렬 작업 처리 등을 통해 대규모 작업을 처리할 수 있습니다. 또한, 클라우드 및 온프레미스 환경의 자동화를 통합하여 하이브리드 환경에서 작업을 관리할 수 있습니다.

  5. 보안 및 감사: Ansible Tower는 보안 기능을 제공하여 데이터의 기밀성과 무결성을 보호합니다. 또한, 작업 실행과 관련된 로그와 보고서를 생성하여 감사 및 규정 준수를 지원합니다.




### 앤서블 설치

- Python PIP

```bash
$ pip install ansible
# 설치 할 앤서블 버전 설정
$ pip install ansible==2.10.7
```

- Python conda

```bash
$ conda install ansible
```

- Ubuntu Linux
```bash
$ sudo apt install ansible
```

- MacOS
```bash
$ brew install ansible
```

#### SSH 연결 사전 설정

##### 절차

- 단계 1. ssh-keygen으로 키를 생성하고,
- 단계 2. ssh-copy-id로 키를 추가합니다.

##### 예시

- 네트워크에 2대의 컴퓨터 {A, B}가 있다고 가정합니다.
- A 는 "192.168.1.5" IP를 갖는다고 하고,
- B 는 "192.168.1.3" IP를 갖는다고 가정합니다.
- B 의 사용자 id는 "jpark"이라고 가정합니다.

- A에서 ssh-keygen으로 먼저 키를 만듭니다.
```bash
$ ssh-keygen -t rsa
```

- private key(비밀키)와 public key(공개키)가 짝으로 만들어집니다.

- A에서 만든 공개키를 B로 전송합니다.
- A의 공개키 ~/.ssh/id_rsa.pub 의 내용이 B에 전달되어 B의 ~/.ssh/authorized_keys 파일에 추가됩니다.

```bash
$ ssh-copy-id jpark@192.168.1.3
```


- A에서 B로 암호 입력 없이 접속 가능합니다.

```bash
$ ssh jpark@192.168.1.3
```


#### Ansible 사용해보기

##### ping으로 연결상태 확인하기

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


##### localhost에서 원격지 컴퓨터로 파일 복사하기 


- copy.yaml 파일을 작성합니다.

```yaml
- name: Test Copy
  hosts: all
  remote_user: jpark
  tasks:
    - name: Copying files from remote server
      copy:
        src: "test.txt"
        dest: "/home/jpark/test_clone.txt"
        backup: yes
```

- copy.yaml 파일을 실행합니다.


```bash
$ ansible-playbook copy.yaml -i server.ini
```


##### localhost에서 원격지 컴퓨터에 명령어를 실행하고 stdout 결과를 확인하기 


- shell_cmd01.yaml 파일을 작성합니다.

```yaml
# This playbook runs a basic DF command.
- hosts: 192.168.1.3
  remote_user: jpark

  tasks:
  - name: find disk space available.
    command: df -hPT
    register: command_output
  - debug:
      var: command_output.stdout_lines

  - name: ls -al
    command: 'ls -al'
    register: command_output
  - debug:
      var: command_output.stdout_lines

  - name: ls
    shell: 'ls'
    register: command_output
  - debug:
      var: command_output.stdout_lines

  - name: uptime
    shell: 'uptime'
    register: command_output
  - debug:
      var: command_output.stdout_lines
```

- shell_cmd01.yaml 파일을 실행합니다.


```bash
$ ansible-playbook shell_cmd01.yaml -i server.ini
```
