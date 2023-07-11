# Ansible 환경 구축

- 시스템 환경 : Ubuntu
- 설치 내용 : Ansible

## 용어

### Playbooks
- Ansible 기본 단위이며, 자동화할 작업 리스트입니다.
- YAML 파일로 작성합니다.

### Control node
- Ansible이 설치된 장치를 말합니다.
- 등록된 여러 노드를 관리합니다.

### Managed nodes
- Control node의 통제를 받는 장치입니다.
- 호스트 라고도 부르며, 별도의 애이전트가 설치되지 않아도 됩니다.

### Inventory
- Control node가 관리하고자 하는 노드의 목록입니다.
- 자동화할 기기들을 포함하고 있습니다.

### Task
- 기본적인 작업 단위위로써 Ansiable Playbook에 포함될 수 있습니다.

### Project
- Playbook 파일이 물리적으로 위치하는 Repository를 뜻합니다.


## 설치

### OpenJDK 17 설치

- openjdk 버전 17 설치
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


