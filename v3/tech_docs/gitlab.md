# 깃랩(GitLab)

- 참고 : https://velog.io/@ysy3285/AWS-Ubuntu-20.04%EC%97%90-GitLab-%EC%84%A4%EC%B9%98
- 깃랩(GitLab)은 깃랩 회사(GitLab Inc.)가 개발한 깃 저장소 및 CI/CD, 이슈 추적, 보안성 테스트 등의 기능을 갖춘 웹 기반의 데브옵스 플랫폼입니다.

## Ubuntu 20.04 LTS 시스템에 GitLab 설치

### 1. 시스템 업데이트

```bash
sudo apt update
sudo apt upgrade -y
```

### 2. 의존성 패키지 설치

```bash
sudo apt install -y ca-certificates curl openssh-server
```

### 3. GitLab-CE repository 추가

```bash
sudo apt install -y ca-certificates curl openssh-server
```
