# System Overview

## 구성

![System Overview](img/overview.png)

다음의 4가지 서브시스템으로 구분 가능

1. 홈클라우드서버 (HHCS; Hybrid Home Cloud Server)

2. 어시스트홈게이트웨이 (AHG; Assist Home Gateway)

3. 홈가전디바이스 (HAD; Home Appliance Device)

4. 홈클라우드디바이스 (HCD; Home Cloud Device)

5. 퍼블릭클라우드서비스 (PCS; Public Cloud Service)

* 참고: AHG는 스마트홈게이트웨이 (SHG; Smart Home Gateway)와 동일


## 기능
상기 5개의 서브시스템들이 유기적으로 연동되어 다양한 서비스 제공 가능
1. 홈클라우드서버 (HHCS) 
> - 서비스 가입 가구별로 1개씩의 AHG 보유하고 있음을 가정
> - HHCS에 여러개의 AHG 연결 가능
> - 외부의 다양한 HCD 혹은 PCS들과 연동하기 위해 RESTful API를 제공

2. 어시스트홈게이트웨이 (AHG)
> - AHG는 안드로이드앱 형태로 배포(APK파일 포멧)
> - AHG 시작과 동시에 HHCS에 연결됨(Socket 통신 수행)
> - 홈 내 HAD들을 인식하고, 관련 리스트와 정보를 HHCS로 전달하여 상태 모니터링
> - HHCS로부터 전달된 제어 명령을 홈 내 HAD들에게 전달하여 기기 제어

3. 홈가전디바이스 (HAD; Home Appliance Device)
> - 본 과제에서는 UPnP를 지원하는 기기들로 한정
> - 외부의 HCD, PCS가 HAD들의 상태를 모니터링과 제어가능
> - 상태 및 제어신호는 HHCS와 AHG를 거치는 것을 기본적으로 가정

4. 홈클라우드디바이스 (HCD; Home Cloud Device)
> - 통상적인 스마트폰이나 PC형태의 디바이스임
> - HHCS에 접속하여 홈 내 HCD들의 상태를 모니터링 하거나 제어
> - 홈 내 발생하는 이벤트 수신도 가능

5. 퍼블릭클라우드서비스 (PCS; Public Cloud Service)
> - 클라우드 기반 서비스의 일종으로써 HHCS에서 제공하는 RESTful API를 기반으로 특정 서비스를 제공 
> - HHCS에 접속하여 홈 내 HCD들의 상태를 모니터링 하거나 제어 가능
> - 홈 내 발생하는 이벤트 수신도 가능

## 구현 요약
> - HHCS 클라우드서버는 NodeJS
> - AHG 게이트웨이는 안드로이드 운영체제 앱
> - HAD 디바이스는 UPnP 기기와 Java언어를 사용한 에뮬레이터
> - HCD 디바이스는 Web browser가 포함된 단말기기 및 PC환경을 가정함
> - PCS 서비스는 RESTful API를 활용하는 외부 서비스로 가정함
  
* 참고: AHG와 HHCS는 당초 RESTful API로 상호 통신하도록 구성되었지만 관련된 여러 문제점들이 발생하여 socket 통신방식으로 변경함 (발생 문제점들의 예: 포트포워딩, 초기 접속지연) 
