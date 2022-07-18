# Redis

## 설치 및 실행 (MacOS)

- 설치 
```bash
    $ brew install redis
```

- 실행
```bash
    $ brew services start redis
```

- 종료 
```bash
    $ brew services stop redis
```

- 재실행
```
    $ brew services restart redis
```


## 기본 사용법

- 콘솔에서 redis-cli 실행

```bash
    $ redis-cli
```

- key와 value 값을 쓰고, 읽기

```bash
    $ set mykey myvalue
    $ get mykey

      "myvalue"

```


- value 값 수정

```bash
    $ set mykey "new myvalue"
```


- key 이름 수정

```bash
    $ rename mykey mykey2
```


- 등록된 key 목록 확인

```bash
    $ keys *
```


- 삭제

```bash
    $ del mykey2
```



## Python 기반 사용법



