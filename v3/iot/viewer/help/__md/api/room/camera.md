# /api/room/camera/:gatewayId/:roomId/list
## 설명

룸에 등록된 카메라 정보들을 가져온다

## Method

GET

## Header
Authorization : Bearer [ACCESS_CODE]

## Parameters

**gatewayId** *required*
게이트웨이의 아이디를 입력한다.

**cameraId** *required*
카메라의 아이디를 입력한다.

## Returns

```javascript
[
  {
    "id": 3,
    "gateway_id": 2,
    "url": "http://192.168.96.51/image.jpg",
    "camera_id": "hhctemp",
    "camera_password": "hhctemp"
  },
  {
    "id": 4,
    "gateway_id": 2,
    "url": "http://192.168.96.51/image.jpg",
    "camera_id": "hhctemp",
    "camera_password": "hhctemp"
  }
]
```

# /api/room/device/:gatewayId/:roomId/:cameraId
## 설명

룸에 카메라를 등록한다

## Method

GET

## Header
Authorization : Bearer [ACCESS_CODE]

## Parameters

**gatewayId** *required*
게이트웨이의 아이디를 입력한다.

**roomId** *required*
룸의 아이디를 입력한다.

**cameraId** *required*
카메라의 아이디를 입력한다.

## Returns

200

# /api/room/device/:gatewayId/:roomId/:cameraId/remove
## 설명

룸에 등록된 카메라를 등록 해제한다

## Method

GET

## Header
Authorization : Bearer [ACCESS_CODE]

## Parameters

**gatewayId** *required*
게이트웨이의 아이디를 입력한다.

**roomId** *required*
룸의 아이디를 입력한다.

**cameraId** *required*
카메라의 아이디를 입력한다.

## Returns

200
