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


### 4. GitLab-CE repository 추가

```bash

curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash

```


### 5. GitLab 설치

- 설치

```bash

sudo apt update
sudo apt -y install gitlab-ce

```

- 완료 후 메시지 : 멋지 여우 그림

```bash

It looks like GitLab has not been configured yet; skipping the upgrade script.

       *.                  *.
      ***                 ***
     *****               *****
    .******             *******
    ********            ********
   ,,,,,,,,,***********,,,,,,,,,
  ,,,,,,,,,,,*********,,,,,,,,,,,
  .,,,,,,,,,,,*******,,,,,,,,,,,,
      ,,,,,,,,,*****,,,,,,,,,.
         ,,,,,,,****,,,,,,
            .,,,***,,,,
                ,*,.
  


     _______ __  __          __
    / ____(_) /_/ /   ____ _/ /_
   / / __/ / __/ /   / __ `/ __ \
  / /_/ / / /_/ /___/ /_/ / /_/ /
  \____/_/\__/_____/\__,_/_.___/
  

Thank you for installing GitLab!
GitLab was unable to detect a valid hostname for your instance.
Please configure a URL for your GitLab instance by setting `external_url`
configuration in /etc/gitlab/gitlab.rb file.
Then, you can start your GitLab instance by running the following command:
  sudo gitlab-ctl reconfigure

For a comprehensive list of configuration options please see the Omnibus GitLab readme
https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/README.md

Help us improve the installation experience, let us know how we did with a 1 minute survey:
https://gitlab.fra1.qualtrics.com/jfe/form/SV_6kVqZANThUQ1bZb?installation=omnibus&release=16-0


```


### 6. GitLab 설정 변경

- 설정파일 열기

```bash

sudo vi /etc/gitlab/gitlab.rb

# 수정
    external_url 'http://loaclhost:8081'
    
```


- 설정 파일 적용을 위한 재시작

```bash
sudo gitlab-ctl reconfigure
```


### 7. root 초기 비밀번호 확인 및 변경

- (1) root 계정 초기 비밀 번호

```bash
sudo su
cat /etc/gitlab/initial_root_password
```

- (2) root 비밀번호 변경

```bash
sudo gitlab-rails console -e production

user = User.where(id:1).first

user.password='new password'
user.password_confirmation='new password'
user.save

exit
```



## GitLab 페이지를 iframe에 넣기

- (참고) https://blog.victormendonca.com/2017/10/11/how-to-load-gitlab-inside-an-iframe/


