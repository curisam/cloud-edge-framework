# /api/room/device/:gatewayId/:roomId/list
## 설명

룸에 등록된 디바이스 정보들을 가져온다

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
    "id": 23,
    "uuid": "ae67e622-7a66-465e-bab0-28107b1c4cc8",
    "service_descriptor": {
      "details": {
        "baseURL": "http://192.168.96.51:8654",
        "dlnaCaps": null,
        "dlnaDocs": [],
        "friendlyName": "DCS-930L(192.168.96.51:80)",
        "manufacturerDetails": {
          "manufacturer": "D-Link",
          "manufacturerURI": "http://www.dlink.com"
        },
        "modelDetails": {
          "modelDescription": "Wireless Internet Camera",
          "modelName": "DCS-930L",
          "modelNumber": "DCS-930L",
          "modelURI": "http://www.dlink.com"
        },
        "presentationURI": "http://192.168.96.51:80",
        "secProductCaps": null,
        "serialNumber": null,
        "upc": ""
      },
      "embeddedDevices": null,
      "icons": [],
      "identity": {
        "descriptorURL": "http://192.168.96.51:8654/rootdesc.xml",
        "discoveredOnLocalAddress": "192.168.96.18",
        "interfaceMacAddress": null,
        "maxAgeSeconds": 1800,
        "udn": {
          "identifierString": "ae67e622-7a66-465e-bab0-28107b1c4cc8"
        }
      },
      "services": [
        {
          "controlURI": "/rootControl",
          "descriptorURI": "/rootService.xml",
          "eventSubscriptionURI": "/rootEvent",
          "actions": {
            "UPnPNull1": {
              "arguments": [],
              "inputArguments": [],
              "name": "UPnPNull1",
              "outputArguments": []
            },
            "UPnPNull2": {
              "arguments": [],
              "inputArguments": [],
              "name": "UPnPNull2",
              "outputArguments": []
            }
          },
          "serviceId": {
            "id": "RootNull",
            "namespace": "cellvision"
          },
          "serviceType": {
            "namespace": "cellvision",
            "type": "Null",
            "version": 1
          },
          "stateVariables": {
            "NullStatus": {
              "eventDetails": {
                "eventMaximumRateMilliseconds": 0,
                "eventMinimumDelta": 0,
                "sendEvents": true
              },
              "name": "NullStatus",
              "type": {
                "allowedValueRange": null,
                "allowedValues": null,
                "datatype": {
                  "builtin": "STRING"
                },
                "defaultValue": "1"
              }
            }
          }
        }
      ],
      "type": {
        "namespace": "schemas-upnp-org",
        "type": "Basic",
        "version": 1
      },
      "version": {
        "major": 1,
        "minor": 0
      }
    },
    "gateway_id": 1,
    "stat": null
  }
]
```

# /api/room/device/:gatewayId/:roomId/:deviceId
## 설명

룸에 UPNP 디바이스를 등록한다

## Method

GET

## Header
Authorization : Bearer [ACCESS_CODE]

## Parameters

**gatewayId** *required*
게이트웨이의 아이디를 입력한다.

**roomId** *required*
룸의 아이디를 입력한다.

**deviceId** *required*
UPNP 디바이스의 아이디를 입력한다.

## Returns

200

# /api/room/device/:gatewayId/:roomId/:deviceId/remove
## 설명

룸에 등록된 UPNP 디바이스를 등록 해제한다

## Method

GET

## Header
Authorization : Bearer [ACCESS_CODE]

## Parameters

**gatewayId** *required*
게이트웨이의 아이디를 입력한다.

**roomId** *required*
룸의 아이디를 입력한다.

**deviceId** *required*
UPNP 디바이스의 아이디를 입력한다.

## Returns

200
