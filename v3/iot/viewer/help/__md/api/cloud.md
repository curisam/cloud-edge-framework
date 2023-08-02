# /api/cloud/descriptor
## 설명

HHC가 지원하는 클라우드 디바이스의 모든 디스크립터를 전달한다

## Method

GET

## Returns

```javascript
## 클라우드 디바이스 디스크립터들의 배열
```

----

# /api/cloud/descriptor/:type
## 설명

HHC가 지원하는 특정 타입(:type)의 클라우드 디바이스의 모든 디스크립터를 전달한다

## Method

GET

## Parameters

**type** *required*
"SmartThings", "Withings", "WeatherStation" 중 하나를 입력한다

## Returns

```javascript
## 특정 타입의 클라우드 디바이스 디스크립터들의 배열
```

----

# /api/cloud/control/:type/:serviceName
## 설명 

해당 클라우드 디바이스를 제어한다

## Method

POST

## Parameters

**type** *required*
"SmartThings", "Withings", "WeatherStation" 중 하나를 입력한다

**serviceName** *required*
ServiceName을 입력한다.

## Body

```javascript
SmartThings 일 때
  extra :
    deviceId : String
    endpointUrl : String
    deviceType : String
    accessToken : String
예)
/api/cloud/control/SmartThings/setSwitch
{
   "extra":{
      "deviceId":"7b1e032f-98da-425e-9acc-788e74ba7401",
      "deviceType":"switch",
      "endpointUrl":"/api/smartapps/installations/f001456e-5a0f-4308-8bc6-93ae5f08e794",
      "accessToken":"6b6fc275-0f94-482a-a3d7-94d7daf47a9c"
   },
   "payload":{
      "switch":"on"
   }
}


Withings 일 때
  extra :
    accessToken : String
    withingsUserId : Number
    tokenSecret : String
예)
/api/cloud/control/Withings/getBodyMeasure
{
   "extra":{
      "accessToken":"28087f9fb6513c4e941860f05d75b231ff5d469ec87d2cc176ec1180b983",
      "tokenSecret":"c89f15d56b1921b4703e294ff5ece2dc123b4d7546db6676c093e383eb41372",
      "withingsUserId":3971210
   }
}

WeatherStation 일 때
  extra :
    accessToken : String
    deviceId : String
예)
/api/cloud/control/WeatherStation/getMeasure
{  
   "extra":{
      "accessToken":"53eeeb9620775960de60e944|345dba009fa938340ed4222caea75ae1",
      "deviceId":"70:ee:50:01:d0:52"
   }
}
```
payload : 클라우드 디바이스 디스크립터의 서비스에 기재된 inputArgument 를 JSON 형식으로 넣는다.

## Request example

URL : /api/cloud/control/SmartThings/setSwitch

```javascript
{
   "extra": {
      "deviceId": "7b1e032f-98da-425e-9acc-788e74ba7401",
      "deviceType": "switch",
      "endpointUrl": "/api/smartapps/installations/f001456e-5a0f-4308-8bc6-93ae5f08e794",
      "accessToken": "6b6fc275-0f94-482a-a3d7-94d7daf47a9c"
   },
   "payload": {
      "switch": "on"
   }
}
```

## Returns

```javascript
## 클라우드 디바이스 디스크립터의 서비스에 기재된 outputArgument의 값이 JSON 형식으로 리턴 된다.
```