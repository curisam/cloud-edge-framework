# /api/sensor/:gatewayId/:sensorId
## 설명 

해당 게이트웨이(:gatewayId)에 소속된 센서(:sensorId)의 정보를 가져온다.

## Method

GET

## Parameters

**gatewayId** *required*
원하는 게이트웨이의 아이디를 입력한다.

**sensorId** *required*
게이트웨이에 속해있는 센서의 아이디를 입력한다.

## Returns

```javascript
  {
    "id": 1,
    "gateway_id": 4,
    "url": "http://ketiabcs.iptime.org:7000/data/get/temperature",
    "name": "Temperature",
    "gateway": {
      "id": 4,
      "name": "kmtest2",
      "identifier": "87671ac42fb2bbf4"
    }
  }
```

----

# /api/sensor/:gatewayId/:sensorId/remove
## 설명 

해당 게이트웨이(:gateway_id)에 소속된 센서(:sensorId) 정보를 지운다

## Method

GET

## Parameters

**gatewayId** *required*
원하는 게이트웨이의 아이디를 입력한다.

**sensorId** *required*
게이트웨이에 속해있는 센서의 아이디를 입력한다.

## Returns

200

----

# /api/sensor/:gatewayId
## 설명

해당 게이트웨이(:gatewayId)에 소속된 센서 정보 리스트를 가져온다

## Method

GET

## Parameters

**gatewayId** *required*
원하는 게이트웨이의 아이디를 입력한다.

## Returns

```javascript
[
  {
    "id": 1,
    "gateway_id": 4,
    "url": "http://ketiabcs.iptime.org:7000/data/get/temperature",
    "name": "Temperature",
    "gateway": {
      "id": 4,
      "name": "kmtest2",
      "identifier": "87671ac42fb2bbf4"
    }
  }
]
```

----

# /api/sensor
## 설명

새로운 센서 정보를 추가한다

## Method

POST

## Body

**gatewayId** *required*
원하는 게이트웨이의 아이디를 입력한다.

**url** *required*
센서의 데이터를 가져올 수 있는 URL을 입력한다.

**name** *required*
사용자가 지정한 센서의 이름을 입력한다.

## Returns

```javascript
{
  "id": 2,
  "gateway_id": "4",
  "url": "http://ketiabcs.iptime.org:7000/data/get/humidity",
  "name": "Humidity"
}
```

----

# /api/sensor/data/:gatewayId/:sensorId
## 설명

센서의 현재 감지 데이터를 요청한다

## Method

GET

## Parameters

**gatewayId** *required*
원하는 게이트웨이의 아이디를 입력한다.

**sensorId** *required*
게이트웨이에 속해있는 센서의 아이디를 입력한다.

## Returns

```javascript
{
  "value": "28.00",
  "key": "temperature",
  "response": "get"
}
```


