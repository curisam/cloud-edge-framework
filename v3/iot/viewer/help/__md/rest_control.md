# Control

## 개요 

| Type | Value | Description |
| -----------|-----------|-----------|
| Url | /api/{gatewayID}/upnp/{uuid}/{deviceType}*/{serviceType}/{actionName}" | {gatewayID} : 해당 REST 호출에 대한 게이트웨이 ID<br> {uuid} : Upnp 디바이스의 UUID<br> {deviceType} : 내장된 디바이스에 대한 타입, 0개 이상이 될 수 있음<br> {serviceType} : 제어 요청할 서비스에 대한 서비스 타입<br> {actionName} : 제어 이름 |
| Method | `POST` |  |
| Parameter | Input 타입 인자를 JSON 객체 |  |
| Response | Output 타입 인자에 결과 값 |  |

게이트웨이에서 연결된 디바이스중  UUID에 해당하는 디바이스 디스크립터를 가져옵니다.

## 예시 

### Requset

POST /SHS/api/20/upnp/fc4ec57e-b051-11db-88f8-0060085db3f6/schemas-upnp-org:WANDevice:1/schemas-upnp-org:WANConnectionDevice:1/schemas-upnp-org:WANIPConnection:1/GetGenericPortMappingEntry HTTP/1.1

Payload 

~~~javascript

{
  "NewPortMappingIndex": "0"
}

~~~

### Response

~~~javascript

{
  "NewRemoteHost": {
    "argument": {
      "aliases": [
        
      ],
      "direction": "OUT",
      "name": "NewRemoteHost",
      "relatedStateVariableName": "RemoteHost",
      "returnValue": false
    },
    "datatype": {
      "builtin": "STRING"
    },
    "value": null
  },
  "NewExternalPort": {
    "argument": {
      "aliases": [
        
      ],
      "direction": "OUT",
      "name": "NewExternalPort",
      "relatedStateVariableName": "ExternalPort",
      "returnValue": false
    },
    "datatype": {
      "builtin": "UI2"
    },
    "value": {
      "value": 443
    }
  },
  "NewProtocol": {
    "argument": {
      "aliases": [
        
      ],
      "direction": "OUT",
      "name": "NewProtocol",
      "relatedStateVariableName": "PortMappingProtocol",
      "returnValue": false
    },
    "datatype": {
      "builtin": "STRING"
    },
    "value": "TCP"
  },
  "NewInternalPort": {
    "argument": {
      "aliases": [
        
      ],
      "direction": "OUT",
      "name": "NewInternalPort",
      "relatedStateVariableName": "InternalPort",
      "returnValue": false
    },
    "datatype": {
      "builtin": "UI2"
    },
    "value": {
      "value": 443
    }
  },
  "NewInternalClient": {
    "argument": {
      "aliases": [
        
      ],
      "direction": "OUT",
      "name": "NewInternalClient",
      "relatedStateVariableName": "InternalClient",
      "returnValue": false
    },
    "datatype": {
      "builtin": "STRING"
    },
    "value": "192.168.0.6"
  },
  "NewEnabled": {
    "argument": {
      "aliases": [
        
      ],
      "direction": "OUT",
      "name": "NewEnabled",
      "relatedStateVariableName": "PortMappingEnabled",
      "returnValue": false
    },
    "datatype": {
      "builtin": "BOOLEAN"
    },
    "value": true
  },
  "NewPortMappingDescription": {
    "argument": {
      "aliases": [
        
      ],
      "direction": "OUT",
      "name": "NewPortMappingDescription",
      "relatedStateVariableName": "PortMappingDescription",
      "returnValue": false
    },
    "datatype": {
      "builtin": "STRING"
    },
    "value": "03BEB4HTTPS"
  },
  "NewLeaseDuration": {
    "argument": {
      "aliases": [
        
      ],
      "direction": "OUT",
      "name": "NewLeaseDuration",
      "relatedStateVariableName": "PortMappingLeaseDuration",
      "returnValue": false
    },
    "datatype": {
      "builtin": "UI4"
    },
    "value": {
      "value": 0
    }
  }
}
~~~
