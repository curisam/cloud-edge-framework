# Ansible 환경 구축

- 시스템 환경 : Ubuntu
- 설치 내용 : Ansible

## 설치

- openjdk 버전 17 설치

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
