# 주요 GIT 명령어

- 참고주소 : todo

## 코드 commit 루틴

- .gitignore 작성

- git 명령어 실행

```bash
$ git add
$ git commit -m "작업한 코드 내용"
$ git push
```


## .gitignore 에 정의된 파일 정리(삭제)하기

ignore 되는 현재 작업 디렉토리(pwd)의 파일 목록을 표시합니다.
```bash
$ git clean -Xn 
```

ignore 되는 현재 작업 디렉토리(pwd)의 파일 목록을 삭제합니다.
```bash
$ git clean -Xf
```

{ignore 되는 파일} + {git에서 관리하지 않는 untracked 파일}을 확인 합니다
위와 유사하지만 -X 대신 소문자인 -x 옵션을 사용합니다.
```bash
$ git clean -xn
```

{ignore 되는 파일} + {git에서 관리하지 않는 untracked 파일} 까지 제거합니다
```bash
$ git clean -xf
```


## git 에 잘못 등록된 파일을 재귀적으로 제거하기

- 예를들어, .DS_Store 라는 파일이 포함되어 있다면 아래와 같은 명령어를 사용하여 git 관리에서 제거할 수 있습니다.

```bash
    $ find . -name .DS_Store -print0 | xargs -0 git rm -f --ignore-unmatch
```


