# /api/room/cloud/:gatewayId/:roomId/list
## 설명

룸에 등록된 클라우드 디바이스 정보들을 가져온다

## Method

GET

## Header
Authorization : Bearer [ACCESS_CODE]

## Parameters

**gatewayId** *required*
게이트웨이의 아이디를 입력한다.

**roomId** *required*
룸의 아이디를 입력한다.

## Returns

```javascript
[
  {
    "id": 29,
    "user_id": 1,
    "uuid": "089b5549-1205-4d2b-81a4-70beb1aa3446",
    "cloud_type": "SmartThings",
    "token_id": 6,
    "descriptor": {
      "tokenId": 6,
      "deviceId": "089b5549-1205-4d2b-81a4-70beb1aa3446",
      "deviceName": "SmartSense Multi",
      "deviceType": "temperatureMeasurement",
      "friendlyName": "SmartSense Multi",
      "state": null,
      "cloudType": "SmartThings",
      "services": [
        {
          "serviceName": "getTemperature",
          "arguments": [
            {
              "name": "temperature",
              "direction": "OUT"
            }
          ],
          "inputArguments": [],
          "outputArguments": [
            {
              "name": "temperature",
              "direction": "OUT"
            }
          ]
        }
      ]
    }
  }
]
```

# /api/room/cloud/:gatewayId/:roomId/:cloudDeviceId
## 설명

룸에 클라우드 디바이스를 등록한다

## Method

GET

## Header
Authorization : Bearer [ACCESS_CODE]

## Parameters

**gatewayId** *required*
게이트웨이의 아이디를 입력한다.

**roomId** *required*
룸의 아이디를 입력한다.

**cloudDeviceId** *required*
클라우드 디바이스의 아이디를 입력한다.

## Returns

200

# /api/room/cloud/:gatewayId/:roomId/:cloudDeviceId/remove
## 설명

룸에 등록된 클라우드 디바이스를 등록 해제한다

## Method

GET

## Header
Authorization : Bearer [ACCESS_CODE]

## Parameters

**gatewayId** *required*
게이트웨이의 아이디를 입력한다.

**roomId** *required*
룸의 아이디를 입력한다.

**cloudDeviceId** *required*
클라우드 디바이스의 아이디를 입력한다.

## Returns

200
