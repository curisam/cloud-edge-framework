# Download & Install

## 패키지 다운로드 및 설치

KETI의 HHCS 홈클라우드 서버의 서비스를 기반으로 하는 퍼블릭 클라우드 서비스를 PCS 개발 및 테스트하기 위해서는 다음과 같은 2가지 방법이 가능합니다.

- (Fast scheme) 운용 서버 + 자체 데모환경
> 댁 내 게이트웨이와 연동되는 테스트용 홈클라우드서버는 KETI에서 제공하는 서버를 활용합니다.
~~~
  http://ketihhc.iptime.org:8181
~~~
> 상기 서버에서 제공하는 RESTful API를 활용하여 다양한 서비스를 개발합니다.
~~~
  http://ketihhc.iptime.org:8181/api/{상세API}
~~~


- (Full scheme) 서버 자체 구축 + 자체 데모환경
> HHCS 홈클라우드 서버를 자체적으로 구축하고 이를 활용하여 자체 데모환경을 만들 수 있습니다.
> 이를 위해서는 MySQL database 연동이 필요하고, NodeJS 를 설치하여 시스템을 구축해야 합니다.

- 본 문서에서는 "Full scheme"을 설명합니다. 
- 따라서 서버 자체 구축이 불필요한 경우 이를 생략하셔도 됩니다.


### 사전준비 (서버구축)
- 운영체제: Ubuntu 14.04.1 LTS
- 데이터베이스: MySQL
> MySQL 서버를 구동시키고, 외부네트워크에서 접속 가능하도록 3306 포트를 개방합니다.
~~~
    (예시)
    ketihhc.iptime.org:3306
~~~
> 제공된 {HHCS데이터베이스}.sql 파일을 이용하여 DB를 생성합니다.
> 상기 DB는 HHCS서버와 연동되므로 사용자 ID, PASSWORD를 부여하고 이를 HHCS에서 활용합니다.
 

### 1. 홈클라우드서버 (HHCS; Hybrid Home Cloud Server)

#### (참고) How To Install Node.js on an Ubuntu 14.04 server
https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-an-ubuntu-14-04-server

#### 설치 
홈클라우드 서버는 NodeJS + Express 웹 프레임워크를 사용하여 개발되었습니다.
따라서 다음의 절차를 통해 서버를 실행하실 수 있습니다.
단, DB 설정과 관련하여 일부 코드 수정이 발생할 수 있습니다.

- 서버준비 및 외부접속 포트개방
> 지원운영체제: 윈도우즈, 맥, 리눅스
> 외부망 연결 포트: 8181

- 서버 구동을 위한 NodeJS 다운로드 및 설치 
> http://nodejs.org/

- 서버코드 압축해제
> unzip {서버압축파일}

- 서버 폴더로 이동
> cd {서버폴더}

- 의존성 패키지 설치
> sudo apt-get install git
> sudo apt-get install nodejs-legacy
> npm install

- 서버 실행
> node app.js
> * DB 연동에 문제가 있는 경우 실행이 되지 않을 수 있습니다. app.js에서 DB 연동관련 코드를 수정하여 주십시요. 
~~~
app.use(orm.express("mysql://{MYSQL_ID}:{MYSQL_PASSWORD}@{서버IP}/hhcdb_test" ...
~~~

- 접속 테스트
> http://localhost:8181/
> * 포트는 8181로 초기 설정됨
> * 게이트웨이에서 서버에 접속하기 위해서는 외부에서 접속 가능한 IP 할당이 선행되어야 함

### 2. 어시스트홈게이트웨이 (AHG; Assist Home Gateway)
- 설치
> {게이트웨이}.apk 파일을 안드로이드 운영체제가 설치된 게이트웨이에 설치 

- 게이트웨이 실행
> 설치된 {게이트웨이} 앱 실행

- 서버접속
> {서버 주소}에 접속
> ketihhc.iptime.org:8181는 테스트 서버임


### 3. 홈가전디바이스 (HAD; Home Appliance Device)
- UPnP 장치들 (다음은 KETI 스마트미디어연구센터에서 기 확인한 사항)
> (오디오) Denon UPnP Audio 
> (TV) Samsung Smart TV
> (조명) Thin Client (TC) + Smart 전등
> (센서) TC + 온도계측
> (센서) TC + 습도계측

- 개발용 시뮬레이터
> {데스크탑시뮬레이터}.jar


### 4. 홈클라우드디바이스 (HCD; Home Cloud Device)
- PC
  주소를 smartphone이나 smart pad를 통해 접속

### 5. 퍼블릭클라우드서비스 (PCS; Public Cloud Service)
>  RESTful API로 접근
