# HTTPS 인증서 발급 및 인증

- HTTPS ? Hypertext Transfer Protocol Secure 의 약자로써, TLS(Transport Layer Security)나 SSL(Secure Sockets Layer)를 사용하여 암호화 하는 방식을 의미 
- HTTPS 를 사용하는 웹 사이트는 "https://"가 접두어이며, CA(인증기관)으로부터 SSL 인증서를 받게됨 
- CA? Certificate Authority의 약자로써, 인증기관을 의미함. 통상적으로 매우 엄격한 검증을 통해 인증기관의 지위를 획득함
- 자체 CA? 편의를 위해서 자체적으로 CA 서버를 구성할 수 있음. 이 경우 보안에 문제가 있을 수 있으며, 최근의 브라우저들은 "강력한 경고 메시지"를 띄워서 접속하지 않을 것을 권고함 
- SSL 인증서 ? 웹 사이트의 신원을 확인해주는 디지털 인증서임. SSL 기술을 사용하여 전송 정보를 암호화 시킴. SSL 인증서에는 {인증서 보유자 이름, 인증서의 일련 번호 및 만료일, 인증서 보유자의 공개 키 복사본, 인증서 발행 기관의 디지털 서명}이 들어감 


## 서버에서 HTTPS 프로토콜 사용을 위해서 CA로부터 인증서를 발급받는 과정
- (Server) 서버공개키(public_key_server)와 서버비밀키(private_key_server)를 생성함
- (Server to CA) 서버는 CA에게 {서버공개키(public_key_server), 서버정보}를 제출함
- (CA) CA는 서버에게서 받은 {서버공개키(public_key_server), 서버정보, 추가인증정보}를 묶어서 {SSL 인증서} 생성함
- (CA) SSL 인증서 암호화를 위해 CA 내부적으로 CA공개키(public_key_ca)와 CA비밀키(private_key_ca)를 생성함
- (CA) CA비밀키(private_key_ca)로 SSL 인증서를 암호화, 이를 통해 {암호화된 SSL 인증서} 생성함
  . 기술적으로 재미있게도, CA공개키(public_key_ca)로 암호화된 SSL 인증서를 해독할 수 있음
  . 달리말하면, 암호화된 SSL 인증서가 CA공개키(public_key_ca)로 풀린다면, CA이가 발급한 SSL 인증서가 맞다는 것을 보장함
- (CA to Server) {암호화된 SSL 인증서, CA부가정보}를 서버에 전달하여 SSL 인증서 발급을 완료함



## 클라이언트에서 서버 접속 시 SSL Handshake과정

- 참고 
  . https://nuritech.tistory.com/25 
  . https://eun-jeong.tistory.com/27


## 브라우저에서 웹사이트 서버 접속 시 인증과정
- (브라우저 and 서버) 브라우저와 서버는 handshake를 통해 임의 데이터를 주고 받음.
- (서버 to 브라우저) 브라우저는 CA비밀키(private_key_ca)로 암호화된 {암호화된 SSL 인증서}를 받음
- (브라우저) 브라우저는 자신이 가지고 있는 CA목록 중에서, 다수의 CA 공개키 중에서 전달받은 {암호화된 SSL 인증서}가 복호화 되는지를 확인함
  . 복호화가 안된다면 {암호화된 SSL 인증서}는 CA에서 발급한 인증서가 아님
  . 복호화가 된다면 {암호화된 SSL 인증서}는 CA에서 발급한 인증서임



