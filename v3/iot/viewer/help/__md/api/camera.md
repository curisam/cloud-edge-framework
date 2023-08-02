# /api/camera/:gatewayId/:cameraId
## 설명 

해당 게이트웨이(:gatewayId)에 소속된 카메라(:cameraId)의 사진을 가져온다

## Method

GET

## Parameters

**gatewayId** *required*
원하는 게이트웨이의 아이디를 입력한다.

**cameraId** *required*
게이트웨이에 속해있는 카메라의 아이디를 입력한다.

## Returns

[Image]

----

# /api/camera/:gatewayId/:cameraId/remove
## 설명 

해당 게이트웨이(:gateway_id)에 소속된 카메라(:cameraId) 정보를 지운다

## Method

GET

## Parameters

**gatewayId** *required*
원하는 게이트웨이의 아이디를 입력한다.

**cameraId** *required*
게이트웨이에 속해있는 카메라의 아이디를 입력한다.

## Returns

200

----

# /api/camera/:gatewayId
## 설명

해당 게이트웨이(:gatewayId)에 소속된 카메라 정보 리스트를 가져온다

## Method

GET

## Parameters

**gatewayId** *required*
원하는 게이트웨이의 아이디를 입력한다.

## Returns

```javascript
[
  {
    "id": 2,
    "gateway_id": 2,
    "url": "http://192.168.96.51/image.jpg",
    "camera_id": "hhctemp",
    "camera_password": "hhctemp"
  },
  {
    "id": 3,
    "gateway_id": 2,
    "url": "http://192.168.96.51/image.jpg",
    "camera_id": "hhctemp",
    "camera_password": "hhctemp"
  }
]
```

----

# /api/camera
## 설명

새로운 카메라 정보를 추가한다

## Method

POST

## Body

**gatewayId** *required*
원하는 게이트웨이의 아이디를 입력한다.

**url** *required*
카메라의 사진 정보를 가져올 수 있는 URL을 입력한다.

**camera_id** *required*
카메라 사진정보를 가져올 때 HTTP Basic 인증에 사용하는 아이디를 입력한다.

**camera_password** *required*
카메라 사진정보를 가져올 때 HTTP Basic 인증에 사용하는 암호를 입력한다.

## Request example
gateway_id=2&url=http%3A%2F%2F192.168.96.51%2Fimage.jpg&camera_id=hhctemp&camera_password=hhctemp

## Returns

```javascript
{
  "id": 4,
  "gateway_id": "2",
  "url": "http://192.168.96.51/image.jpg",
  "camera_id": "hhctemp",
  "camera_password": "hhctemp"
}
```


