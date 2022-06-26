# poetry 설치

- 참고 : https://python-poetry.org/docs/

## poetry를 설치합니다.

```bash
$ curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
```

- 아래처럼 설치 스크립트를 파일로 저장한 후에 설치할 수도 있습니다.

```bash
$ curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py > get-poetry.py

$ python3 get-poetry.py

```



## poetry 환경변수를 설정합니다.

```bash
$ vi .zshrc 
```

- 파일에 아래 명령행을 추가합니다.
```bash
  export PATH="$HOME/.poetry/bin:$PATH"
```

## 환경변수 설정이 잘되는지, 실행해 봅니다.

```bash
$ poetry --version
```
python get-poetry.py --uninstall
POETRY_UNINSTALL=1 python get-poetry.py


## 프로그램 제거도 할 수 있습니다.

```bash
$ python get-poetry.py --uninstall
POETRY_UNINSTALL=1 python get-poetry.py
```
