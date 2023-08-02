# 보안서비스 사용하기(Quick Start)
 
 
## <a id="helpNotice"></a> 기 확보된 정보 
 
 - 한국사물인증센터로부터 사전에 ID, PW를 발급 받습니다.
 - 한국사물인증센터 사전에 단말용 인증키를 발급 받습니다. (스마트단말, Iot 단말 각각 독립적으로 1개씩)

## <a id="helpNotice"></a> 기 확보된 정보 
 
 - ID, PW, 단말용 인증키를 준비합니다.(없으면 한국사물인증센터에서 발급받습니다.)
 - 스마트단말에서 브라우저를 열어 서비스 페이지에 접속합니다.(http://ketihhc.iptime.org/2017seciot)
  > 스마트단말에 앱을 설치하여 보안 인증하는 경우에는 ID/PW만 입력합니다. 이때는 한국사물인증센터에서 배포한 앱에 대해서만 보안인증을 보장합니다. 
 - ID, PW로 로그인 합니다.(http://ketihhc.iptime.org/2017seciot/step1_login.php)
  > 시험계정 ID: testuser, PW: testuser 
 - 무결성 검증 정보들을 보안인증서버에 전달합니다.(http://ketihhc.iptime.org/2017seciot/step2_verify_integrity.php)
  > 시험 디바이스 정보: "KETI Smart Device 1", 시험 시리얼번호: "AAAA0001"
 - (UI 없는 부분) 무결성 검증을 수행합니다.
 - 무결성 검증이 완료되면 보안인증 서버에서 생성한 난수값을 확인합니다.
 - (UI 없는 부분) 무결성 검증이 완료되면 연동된 Iot장치들에게 
 
## <a id="introApi2"></a> RESTful API ?
- 기기들의 상태정보를 획득하고, 제어하기 위해 RESTful 방식의 인터페이스를 기술함


# 주의하세요 !
 - 서버와 클라이언트 사이의 데이터 전송을 위해 GET 방식으로 파라미터 전달하고 있습니다.
 - 개발단계에서 디버깅을 용이하게 하기 위함입니다.
 - 실 서비스를 고려하신다면 GET방식은 보안에 취약하니, POST방식 등으로 수정이 필요합니다.


# MQTT 프로토콜 사용을 위해 미리 설치하세요
 - 리눅스 터미널에서 paho-mqtt 를 설치합니다.
 
```bash
    pip install --upgrade pip
    pip install paho-mqtt
```

 - (옵션) 하이브리드 앱 개발을 위해서는 Ionic 프레임워크를 설치합니다.

```python
 npm install -g ionic cordova
```
