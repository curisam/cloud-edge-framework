-----------------------------------------------------
# 기술문서 
 - 기술문서명 : 고성능 프로토콜 버퍼 기반의 원격프로시저콜 gRPC 기술
 - 과제명 : 능동적 즉시 대응 및 빠른 학습이 가능한 적응형 경량 엣지 연동분석 기술개발
 - 영문과제명 : Development of Adaptive and Lightweight Edge-Collaborative Analysis Technology for Enabling Proactively Immediate Response and Rapid Learning
 - Acknowledgement : This work was supported by Institute of Information & communications Technology Planning & Evaluation (IITP) grant funded by the Korea government(MSIT) (No. 2021-0-00907, Development of Adaptive and Lightweight Edge-Collaborative Analysis Technology for Enabling Proactively Immediate Response and Rapid Learning).
 - 작성자 : 박종빈
-----------------------------------------------------

## gRPC

- gRPC ?

  . Google에서 만든 RPC (Remote Procedure Call)

- RPC ?
  
  . 네트워크 상의 컴퓨터 상호간에 프로시저를 원격으로 호출 하는 방법

- gRPC pros ?

  . Protocol buffer 를 사용하여 유지보수 쉬움
  . 다양한 언어 및 플랫폼 지원
  . 양방향 스트리밍 가능

- gRPC cons ?
  . 복잡
  . binary 메시지 해독이 어려워서 디버깅 난이도 증가 




- references (grpc-go)

  . https://grpc.io/docs/languages/go/quickstart/
  . https://earthly.dev/blog/golang-grpc-example/


- references (grpc-python)



## Install  


- Install 'go'

```bash
    $ brew install go
```

- Install protocol buffer on Mac 

```bash
    $ brew install protobuf
```

- Check protocol buffer

```bash
    $ protoc --version

    libprotoc 3.21.2
```

- Install gRPC

```bash
    $ brew install grpc 
    $ brew install grpcurl
    $ go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.26
    $ go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```


- Add path

```bash
    $ export PATH="$PATH:$(go env GOPATH)/bin"
```


- Example

  . https://grpc.io/docs/languages/go/quickstart/

  o


## Python example


- Install

```bash
    $ python -m pip install --upgrade pip 
    $ python -m pip install virtualenv
    $ virtualenv venv
    $ source venv/bin/activate
    $ python -m pip install --upgrade pip

    $ python -m pip install grpcio
    $ python -m pip install grpcio-tools
```

- Download example

```bash
    # Clone the repository to get the example code:
    $ git clone -b v1.46.3 --depth 1 --shallow-submodules https://github.com/grpc/grpc
    # Navigate to the "hello, world" Python example:
    $ cd grpc/examples/python/helloworld

```

- Run server

```bash
    $ source venv/bin/activate
    $ cd grpc/examples/python/helloworld
    $ python greeter_server.py
```

- Run server, (new terminal window) 

```bash
    $ source venv/bin/activate
    $ cd grpc/examples/python/helloworld
    $ python greeter_client.py
```


