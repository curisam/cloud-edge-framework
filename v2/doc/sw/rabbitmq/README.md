# RabbitMQ

- 메시지 전달 브로커 기술

## Kafaka vs. RabbitMQ vs. MQTT ?

### Kafaka

- {대용량, 실시간} 로그 처리에 특화된 메시징 시스템
- 대용량의 streaming, 파이라인등을 이용 시 적합
- 이벤트 스토어, 히스토리 같은 순서 보장시 사용
- [+] 타 메시징 시스템 대비 TPS(Transaction Per Second)가 매우 우수
- [+] 성능개선을 위해 AMQP 프로토콜이나 JMS API를 사용하지 않고 단순 헤더 정보로 TCP 기반 프로토콜을 사용함
- [+] 다수의 메시지를 batch 형태로 Broker에게 한번에 전달 가능
- [+] 큐의 기능은 RbbitMQ, JMS등에 비해 많이 부족하지만, 대용량 메시지 처리가 최대 장점
- [+] 메시지를 파일로 저장 : 시스템 장애시에 복구 가능
- [-] 성능에 특화되어 다른 범용 메시징 시스템에서 제공하는 유용한 기능 적음
- [+] 메시지 전송 순서 보장


### RabbitMQ
- AMQP 프로토콜을 구현
- [+] 다양한 기능 : {신뢰성, 안정성, 성능}을 고려함
- [+] 브로커가 유연하고 다양한 라우팅 제공
- [+] 종래의 주요 프로토콜 (STOMP, MQTT, AMQP)를 지원 해야할때 사용
- [+] 관리자 UI를 제공하여 사용이 편리함
- [+] 클러스터링: 클러스터 구축 가능
- [+] 상업적 이용 가능한 오픈 소스
- [-] 메시지 전송 순서 보장하지 않음

### MQTT

초 경량 메시지 큐 프로토콜로 발행-구독(Pub/Sub) 방식에 초첨을 두고 있음
AMQP와 마찬가지로 상호 운용이 가능하며, 임베디드 시스템에서 대규모 배포에 매우 적합
AMQP 처럼 구독 관리와 메시지 라우팅을 위해 브로커에 의존 함

### ZeroMQ

- 중앙 집중형 브로커 없이 메시지 전달 가능
- 하지만 브로커가 제공하는 영속성 및 전달 보장성은 없음
- 요청-응답(REQ-REP) 패턴, 발행-구독(PUB-SUB) 패턴 제공
- PUSH-PULL 방식을 제공해, 단 방향으로 흐르는 데이터 스트림을 다루는데 효과적
[+] 가벼움
[+] 빠름
[+] 브로커 필요 없음
[+] 상호 운용 가능
[-] 메시지 신뢰성이 다소 떨어짐


## 설치하기 (Mac)

- brew install

```bash
brew update
brew install rabbitmq
```

- 경로 설정하기

```bash
     export PATH=/opt/homebrew/sbin:$PATH
```

- 관리자 계정추가

```bash
    $ sudo rabbitmqctl add_user rabbitmq password
    $ sudo rabbitmqctl set_user_tags rabbitmq administrator
```

- 관리자 UI 접속하기

```bash
    $ open http://localhost:15672/

    id : rabbitmq
    pw : password
```

- 사용자 확인

```bash
    $ rabbitmqctl list_users
```