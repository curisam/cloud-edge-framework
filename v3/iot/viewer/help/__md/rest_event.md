# Event

## 개요 

| Type | Value | Description |
| -----------|-----------|-----------|
| Url | /api/{gatewayID}/event/{lastUpdateTime} | {gatewayID} : 해당 REST 호출에 대한 게이트웨이 ID<br> {lastUpdateTime} : 최근 이벤트를 받은 시간(long 타입), 무조건 값을 가져오고 싶으면 0으로 값을 넣음 |
| Method | `POST` |  |
| Parameter | Input 타입 인자를 JSON 객체 |  |
| Response | Output 타입 인자에 결과 값 |  |

게이트웨이에 연결된 Upnp 디바이스의 비동기 이벤트 정보를 Long Polling 방식을 이용해 가져옵니다. 

서버의 기본 타임아웃은 5초입니다.

## 예시 

### Requset

GET /SHS/api/20/event/0 HTTP/1.1

### Response

~~~javascript

{
  "event": [
    {
      "udn": "311767bc-c98e-3a45-0000-00003efaa72c",
      "currentValues": {
        "Brightness": {
          "datatype": {
            "builtin": "I4",
            "displayString": "i4"
          },
          "value": 0,
          "stateVariable": {
            "name": "Brightness",
            "eventDetails": {
              "sendEvents": true,
              "eventMaximumRateMilliseconds": 0,
              "eventMinimumDelta": 0
            },
            "service": null,
            "typeDetails": {
              "datatype": {
                "builtin": "I4",
                "displayString": "i4"
              },
              "defaultValue": "0",
              "allowedValues": null,
              "allowedValueRange": null
            },
            "moderatedNumericType": false
          }
        },
        "Lighting": {
          "datatype": {
            "builtin": "BOOLEAN",
            "displayString": "boolean"
          },
          "value": true,
          "stateVariable": {
            "name": "Lighting",
            "eventDetails": {
              "sendEvents": true,
              "eventMaximumRateMilliseconds": 0,
              "eventMinimumDelta": 0
            },
            "service": null,
            "typeDetails": {
              "datatype": {
                "builtin": "BOOLEAN",
                "displayString": "boolean"
              },
              "defaultValue": "0",
              "allowedValues": null,
              "allowedValueRange": null
            },
            "moderatedNumericType": false
          }
        }
      },
      "serviceType": {
        "namespace": "schemas-upnp-org",
        "type": "LightingService",
        "version": 1
      },
      "serviceId": {
        "namespace": "upnp-org",
        "id": "LightingService"
      },
      "date": 1390463941948
    },
    {
      "udn": "311767bc-c98e-3a45-ffff-ffff81697049",
      "currentValues": {
        "FamilyList": {
          "datatype": {
            "builtin": "STRING",
            "displayString": "string"
          },
          "value": null,
          "stateVariable": {
            "name": "FamilyList",
            "eventDetails": {
              "sendEvents": true,
              "eventMaximumRateMilliseconds": 0,
              "eventMinimumDelta": 0
            },
            "service": null,
            "typeDetails": {
              "datatype": {
                "builtin": "STRING",
                "displayString": "string"
              },
              "defaultValue": null,
              "allowedValues": null,
              "allowedValueRange": null
            },
            "moderatedNumericType": false
          }
        },
        "Event": {
          "datatype": {
            "builtin": "STRING",
            "displayString": "string"
          },
          "value": "{\n  \"who\": \"Father\",\n  \"where\": \"Room1\",\n  \"type\": \"Checkout\",\n  \"time\": 1390462617039\n}",
          "stateVariable": {
            "name": "Event",
            "eventDetails": {
              "sendEvents": true,
              "eventMaximumRateMilliseconds": 0,
              "eventMinimumDelta": 0
            },
            "service": null,
            "typeDetails": {
              "datatype": {
                "builtin": "STRING",
                "displayString": "string"
              },
              "defaultValue": null,
              "allowedValues": null,
              "allowedValueRange": null
            },
            "moderatedNumericType": false
          }
        },
        "Move": {
          "datatype": {
            "builtin": "STRING",
            "displayString": "string"
          },
          "value": null,
          "stateVariable": {
            "name": "Move",
            "eventDetails": {
              "sendEvents": true,
              "eventMaximumRateMilliseconds": 0,
              "eventMinimumDelta": 0
            },
            "service": null,
            "typeDetails": {
              "datatype": {
                "builtin": "STRING",
                "displayString": "string"
              },
              "defaultValue": null,
              "allowedValues": null,
              "allowedValueRange": null
            },
            "moderatedNumericType": false
          }
        },
        "SpaceList": {
          "datatype": {
            "builtin": "STRING",
            "displayString": "string"
          },
          "value": null,
          "stateVariable": {
            "name": "SpaceList",
            "eventDetails": {
              "sendEvents": true,
              "eventMaximumRateMilliseconds": 0,
              "eventMinimumDelta": 0
            },
            "service": null,
            "typeDetails": {
              "datatype": {
                "builtin": "STRING",
                "displayString": "string"
              },
              "defaultValue": null,
              "allowedValues": null,
              "allowedValueRange": null
            },
            "moderatedNumericType": false
          }
        }
      },
      "serviceType": {
        "namespace": "schemas-upnp-org",
        "type": "ConditionInfoService",
        "version": 1
      },
      "serviceId": {
        "namespace": "upnp-org",
        "id": "ConditionInfoService"
      },
      "date": 1390462627123
    }
  ],
  "time": 1390463932178
}

~~~
