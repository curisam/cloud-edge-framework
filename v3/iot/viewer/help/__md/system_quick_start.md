# Quick Start

## 목적 
* 본 문서에서 (1) 웹 UI를 이용해서 홈 내 기기를 제어하는 예시, (2) RESTful API를 이용하여 홈 내 기기를 제어하는 방법을 정리합니다.
* 이를 통해 프레임워크의 동작 구조를 설명하고자 합니다.

## 기술적 특징
* HHCS와 AHG는 소켓통신 방식으로 수정되었습니다 (2차년도 구조는 RESTful API롤 상호 연동되었으나, 포트포워딩문제와 접속지연문제가 발생하여 구조를 수정했습니다.) 
* 본 프레임워크는 OAuth2.0인증 방법을 적용했습니다.




## 1. 웹 UI를 이용해서 홈 내 기기를 제어하는 예시 


----------------------------------------------------------
#### 서버에 접속합니다.

테스트 서버가 local에서 실행중이면 다음과 같이 localhost로 접속합니다. 
~~~
  http://localhost:8181
~~~ 

서버가 없다면 KETI에서 운영중인 테스트 서버를 이용 가능합니다.
~~~ 
  http://ketihhc.iptime.org:8181
~~~ 
![01_hhcs](img/01_hhcs.png)



----------------------------------------------------------
#### 사용자를 등록합니다.
Email, Name, Password를 입력하면 서버에 사용자 등록이 됩니다.
아래와 같이 이미 등록된 TestUser 정보로 접속가능합니다. 
~~~json
{
    Email: "a@a.com",
    Name: "TestUser",
    Password: "12345"
}
~~~ 
![02_register](img/02_register.png)


----------------------------------------------------------
#### 등록된 Gateway를 확인해 봅니다.
HHCS 웹페이지 상단의 Gateway 탭을 클릭해서 등록된 Gateway가 있는지 확인해 봅니다.
처음에는 빈페이지 상태입니다.
HHCS에 연결된 AHG(Assist Home Gateway)가 없기 때문입니다.

![03_hhcs_gateway](img/03_hhcs_gateway.png)


----------------------------------------------------------
#### AHG 게이트웨이 앱 실행
AHG는 안드로이드 앱 형태입니다.
AHG앱을 실행시키면 그림과 같이 Gateway Name, Server Domain을 입력하게 되어 있습니다.
실행중인 서버주소를 입력하고 "Enter"버튼을 클릭하면 접속됩니다.
![04_gateway_start1](img/04_gateway_start1.png)

게이트웨이가 서버에 접속된 상태입니다.
![05_gateway_start2](img/05_gateway_start2.png)


----------------------------------------------------------
#### 홈 내 UPnP 장치 확인
AHG는 홈 내 UPnP 장치들을 {발견, 상태확인, 제어}할 수 있습니다.
이는 HHCS와 연동되어 이뤄집니다. 
홈 내 UPnP 장치를 우리는 HAD(Home Appliace Device)라고 부릅니다.
빠른 테스트를 위해 가상의 HAD를 생성하는, PC용 시뮬레이션 프로그램을 만들었습니다.
이를 실행시킨 모습은 아래와 같습니다.
약 10개 정도의 가상 UPnP 장치들을 시뮬레이션 해볼 수 있습니다.

![06_had_desktopsimulator_heater_active](img/06_had_desktopsimulator_heater_active.png)

가상 장치들은 처음에는 꺼져 있는 상태입니다.
가상 Heater를 켜기 위해서 "Upnp Service Start"버튼을 클릭합니다.
그러면 AHG가 이 장치를 인식할 수 있습니다.
![07_had_desktopsimulator_heater_inactive](img/07_had_desktopsimulator_heater_inactive.png)


----------------------------------------------------------
#### AHG에서 HAD 확인
AHG의 Device 탭이나 Details 탭을 통해 홈 내 UPnP기반 HAD들을 확인하고 제어할 수 있습니다.
Heater 장치를 확인할 수 있습니다.
![08_ahg_details](img/08_ahg_details.png)


----------------------------------------------------------
#### AHG에서 사용자 정보 입력을 통한 HHCS와의 연동
그러나, AHG는 최초 접속할 때 HHCS의 URL을 입력했지만 아직 누구 소유의 게이트웨이(AHG)인지는 알 방법이 없습니다. 
따라서 AHG의 "Users"탭에서 Email과 Password를 입력하여 AHG의 소유자 정보를 명시합니다.
AHG는 이 정보를 HHCS에게 보내 등록된 사용자라면 소정의 서비스를 제공합니다.

![09_ahg_user_add1](img/09_ahg_user_add1.png)

본 예시에서는 아래와 같은 정보를 입력했습니다.
~~~json
{
    Email: "a@a.com",
    Password: "12345"
}
~~~ 
![10_ahg_user_add2](img/10_ahg_user_add2.png)


입력완료 버튼을 클릭하면 게이트웨이에 등록된 유저 정보가 저장됩니다.
이 정보는 HHCS의 내부 DB에서 관리됩니다.

![11_ahg_user_add3](img/11_ahg_user_add3.png)



----------------------------------------------------------
#### 등록된 Gateway를 다시 확인해 봅니다.
아래 그림과 같이 AHG가 발견한 UPnP기반 HAD들이 나타납니다.
![12_hhcs_gateway_page](img/12_hhcs_gateway_page.png)


----------------------------------------------------------
#### HHCS 웹 페이지상에서 히터 상태정보 확인 및 제어

사전에 "HAD Desktop Simulator"에서 Heater의 상태를 확인해 봅니다.
아래와 같이 false (꺼짐) 상태임을 확인할 수 있습니다.
~~~json
{
    Heater: "false"
}
~~~ 
![14_had_desktopsimulator_heater_false](img/14_had_desktopsimulator_heater_false.png)

이제 HHCS에서 홈 내 Heater를 켜 보겠습니다.
게이트웨이 제어 창에서 Heater 리스트를 클릭합니다. 
![13_hhcs_gateway_page_heater_control](img/13_hhcs_gateway_page_heater_control.png)


"Service:HeaterService"를 클릭하고 "GetHeater"를 클릭합니다.
다이어로그 박스가 뜨면 "Call" 버튼을 클릭합니다.
Heater가 false 상태임을 확인할 수 있습니다. 
![15_hhcs_gateway_page_heater_control_get_false](img/15_hhcs_gateway_page_heater_control_get_false.png)


"Service:HeaterService"를 클릭하고 "SetHeater"를 클릭합니다.
다이어로그 박스가 뜨면 "NewHeaterValue"에 "true"를 입력하고 "Call" 버튼을 클릭합니다.
~~~json
{
    NewHeaterValue: "true"
}
~~~ 
![16_hhcs_gateway_page_heater_control_set_true](img/16_hhcs_gateway_page_heater_control_set_true.png)

"HAD Desktop Simulator"에서 Heater의 상태를 다시 확인해 봅니다.
아래와 같이 true (켜짐) 상태로 변화 되었음을 확인할 수 있습니다.
즉, 홈 외부에서 HHCS를 통해 홈 내 Heater를 제어했습니다.
![17_had_desktopsimulator_heater_true](img/17_had_desktopsimulator_heater_true.png)


----------------------------------------------------------
#### AHG에서 직접 HAD 제어
AHG에서 HAD를 직접 제어도 가능합니다.
예를들어, 아래 그림과 같이 발견된 Heater를 클릭하면, SetHeater, GetHeater 서비스 목록이 나타납니다.
![20_ahg_heater_control1](img/20_ahg_heater_control1.png)


SetHeater를 클릭하고 NewHeaterValue값에 "false"를 입력하고 확인을 누릅니다.
이 과정을 마친후 HAD Desktop Simulator에서 Heater상태를 확인해 보면 꺼짐 상태로 변화 했음을 확인할 수 있습니다.

![21_ahg_heater_control2](img/21_ahg_heater_control2.png)

![22_ahg_heater_control3](img/22_ahg_heater_control3.png)







----------------------------------------------------------

## 2. RESTful API를 기기 제어 

홈 클라우드 프레임워크는 타 클라우드 기반 서비스들과 연동하여 여러 흥미로운 서비스들을 제공할 수 있습니다.
이러한 연동을 위해서 HHCS는 아래와 같은 형식의 RESTful API를 제공합니다.
~~~
  http://ketihhc.iptime.org:8181/api/{상세API}
~~~
홈 내에서 AHG에 HAD가 연결되면, 기기를 제어할 수 있도록 하는 RESTful API가 동적으로 생성됩니다.
상세한 API는 별도의 document를 확인해 주십시요.
본 문서에서는 이러한 RESTful API를 사용하기 위해 OAuth2.0 인증을 통한 키 할당, node.js 앱으로 실제 기기를 제어하는 예시를 제시합니다.
제시한 예제를 변형하면 홈클라우드 프레임워크 기반 신규서비스 생성이 가능할 것입니다.



#### RESTful API를 사용하여 기기를 제어하는 예시

본, 예제는 인증과 관련된 상세 설명은 생략하고 절차 위주로 기술됩니다. (구현 내용은 별도 문서로 정리 예정입니다.)


##### OAuth2.0 애플리케이션 등록

HHCS 서버에 사용자 아이디로 로그인합니다.
이후, 아래 그림과 같이 HHCS/OAuth 탭을 통해 애플리케이션을 등록합니다.
Title, Redirect URI를 입력하고 Submit 버튼을 클릭합니다.
![30_oauth2](img/30_oauth1.png)

이 과정을 통해 HHCS가 사용자를 인증할 수 있게 하는 {Client ID, Client Secret}를 아래와 같이 할당 받습니다. 
* 할당 받은 정보 
~~~json
{
    Title: "RestfulApiTest",
    RedirectURI: "http://localhost:8181",
    Client ID: "1dcfddba-5aa9-4fcf-8ac8-d0e0d315ec4d",
    Client Secret: "c1e8a48a-d820-442b-b4c3-4be6b22ff8ed	"
}
~~~

![31_oauth2](img/31_oauth2.png)


##### 인증 및 RESTful API 호출을 통한 Heater 제어 예시

HHCS서버는 RESTful API를 동적으로 생성하기 때문에 고정된 URL이 API가 되지 않습니다.
대신 UPnP 디바이스 디스크립터와 서비스 디스크립터를 적절히 조합하여 기기를 제어할 수 있는 명령어를 만들 수 있습니다.
앞서 인증을 위해 할당받은 {Client ID, Client Secret}와 기 등록한 사용자 정보 {user_id, user_password}를 이용하여 실제 기기를 제어하는 node.js 기반 예제는 다음과 같습니다.
(보다 상세한 설명은 추가 기입 예정입니다.)
예제 사용법은 다음과 같습니다.
* package.json 과 OnOffTest.js를 테스트할 폴더에 준비합니다.
* node.js를 설치하고, 테스트폴더에서 의존성 패키지들을 설치합니다.
~~~bash
npm install
~~~
* 예제 앱을 실행합니다.
~~~
node OnOffTester.js
~~~

* 아래와 같이 interactive 방식으로 기기제어를 테스트 해볼 수 있습니다. (아래 예에서는 0, On, Off를 입력했음)
![32_on_off_tester](img/32_on_off_tester.png)


##### package.json
~~~json
{
    "name": "OnOffTester",
    "version": "0.0.1",
    "private": true,
    "scripts": {
        "start": "node OnOffTester.js"
    },
    "dependencies": {
        "request": "*",
        "readline": "*",
        "async" : "*"
    }
}
~~~

##### OnOffTester.js
~~~javascript
// Generated by CoffeeScript 1.8.0
(function() {
  var async, config, readLine, request, rl;

  readLine = require('readline');

  request = require("request");

  async = require('async');

  config = {
    server: 'http://localhost:8181',
    client_id: '1dcfddba-5aa9-4fcf-8ac8-d0e0d315ec4d',
    client_secret: 'c1e8a48a-d820-442b-b4c3-4be6b22ff8ed',
    user_id: 'a@a.com',
    user_password: '12345'
  };

  rl = readLine.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  async.waterfall([
    function(callback) {
      if (config.client_id === null) {
        return rl.question("서버 주소를 입력해주세요\n", function(answer) {
          config.server = answer;
          return callback();
        });
      } else {
        return callback();
      }
    }, function(callback) {
      if (config.client_id === null) {
        return rl.question("Client_ID 를 입력해주세요\n", function(answer) {
          config.client_id = answer;
          return callback();
        });
      } else {
        return callback();
      }
    }, function(callback) {
      if (config.client_id === null) {
        return rl.question("Client_secret 을 입력해주세요\n", function(answer) {
          config.client_secret = answer;
          return callback();
        });
      } else {
        return callback();
      }
    }, function(callback) {
      if (config.client_id === null) {
        return rl.question("User_ID 를 입력해주세요\n", function(answer) {
          config.user_id = answer;
          return callback();
        });
      } else {
        return callback();
      }
    }, function(callback) {
      if (config.client_id === null) {
        return rl.question("User_Password 를 입력해주세요\n", function(answer) {
          config.user_password = answer;
          return callback();
        });
      } else {
        return callback();
      }
    }, function(callback) {
      var requestOption;
      requestOption = {
        url: "" + config.server + "/oauth/token",
        headers: {
          Authorization: "Basic " + (new Buffer(config.client_id + ":" + config.client_secret).toString('base64'))
        },
        form: {
          grant_type: 'password',
          username: config.user_id,
          password: config.user_password
        }
      };
      return request.post(requestOption, function(err, response, oauth) {
        return callback(err, JSON.parse(oauth));
      });
    }, function(oauth, callback) {
      var requestOption;
      requestOption = {
        url: "" + config.server + "/api/gateway/list",
        headers: {
          Authorization: "Bearer " + oauth.access_token
        }
      };
      return request.get(requestOption, function(err, response, gateways) {
        return callback(err, oauth, JSON.parse(gateways));
      });
    }, function(oauth, gateways, callback) {
      var idx, q, questionString, _i, _len;
      idx = 0;
      questionString = gateways.map(function(gateway) {
        return "[" + (idx++) + "] ID : " + gateway.id + ", Nick : " + gateway.nick + ", Domain : " + gateway.domain;
      });
      console.log("게이트웨이 번호를 선택해주세요");
      for (_i = 0, _len = questionString.length; _i < _len; _i++) {
        q = questionString[_i];
        console.log(q);
      }
      return rl.question("", function(answer) {
        return callback(null, oauth, gateways[answer]);
      });
    }, function(oauth, gateway, callback) {
      var dodo;
      dodo = function() {
        return rl.question("히터 On/Off를 설정해주세요[On/Off]\n", function(answer) {
          var requestOption;
          switch (answer) {
            case 'On':
              console.log('on');
              requestOption = {
                url: "" + config.server + "/api/upnp/" + gateway.id + "/ketiuuid0-0000-0had-simu-heater000000/schemas-upnp-org:HeaterService:1/SetHeater",
                headers: {
                  Authorization: "Bearer " + oauth.access_token
                },
                json: {
                  NewHeaterValue: true
                }
              };
              return request.post(requestOption, function(err, response, result) {
                console.log(result);
                return dodo();
              });
            case 'Off':
              console.log('off');
              requestOption = {
                url: "" + config.server + "/api/upnp/" + gateway.id + "/ketiuuid0-0000-0had-simu-heater000000/schemas-upnp-org:HeaterService:1/SetHeater",
                headers: {
                  Authorization: "Bearer " + oauth.access_token
                },
                json: {
                  NewHeaterValue: false
                }
              };
              return request.post(requestOption, function(err, response, result) {
                console.log(result);
                return dodo();
              });
            default:
              return callback("끝");
          }
        });
      };
      return dodo();
    }
  ], function(err) {
    if (err) {
      console.log(err);
      rl.close();
      return process.exit(0);
    }
  });

}).call(this);

~~~




