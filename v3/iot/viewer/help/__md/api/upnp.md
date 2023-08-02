# /api/upnp/gateway

## 설명

모든 AHG 정보를 가져온다.

## Method

GET

## Returns

```javascript
[
  {
    "id": 2,
    "name": "kmtest2",
    "identifier": "87671ac42fb2bbf4",
    "online" : true
  },
  {
    "id": 3,
    "name": "KETI HHC Gateway",
    "identifier": "624eda2d8ee8cda1",
    "online" : false
  }
]
```

----

# /api/upnp/device/:gatewayId
## 설명

해당 게이트웨이(:gatewayId)에 소속된 모든 디바이스의 디스크립터를 가져온다.

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
     "uuid": "fc4ec57e-b051-11db-88f8-0060085db3f6",
     "service_descriptor": {
       "details": {
         "baseURL": null,
         "dlnaCaps": null,
         "dlnaDocs": [],
         "friendlyName": "EFM Networks ipTIME N904NS",
         "manufacturerDetails": {
           "manufacturer": "EFM Networks",
           "manufacturerURI": "http://www.iptime.co.kr"
         },
         "modelDetails": {
           "modelDescription": "EFM Networks ipTIME N904NS",
           "modelName": "ipTIME N904NS",
           "modelNumber": "1",
           "modelURI": "http://www.iptime.co.kr"
         },
         "presentationURI": "http://192.168.0.1/",
         "secProductCaps": null,
         "serialNumber": "12345678",
         "upc": null
       },
       "embeddedDevices": [
         {
            ...
         }
       ],
       "icons": [],
       "identity": {
         "descriptorURL": "http://192.168.0.1:38507/etc/linuxigd/gatedesc.xml",
         "discoveredOnLocalAddress": "10.0.3.15",
         "interfaceMacAddress": null,
         "maxAgeSeconds": 120,
         "udn": {
           "identifierString": "fc4ec57e-b051-11db-88f8-0060085db3f6"
         }
       },
       "services": [
         {
           "controlURI": "/dummy",
           "descriptorURI": "/etc/linuxigd/dummy.xml",
           "eventSubscriptionURI": "/dummy",
           "actions": {},
           "serviceId": {
             "id": "dummy1",
             "namespace": "dummy-com"
           },
           "serviceType": {
             "namespace": "schemas-dummy-com",
             "type": "Dummy",
             "version": 1
           },
           "stateVariables": {}
         }
       ],
       "type": {
         "namespace": "schemas-upnp-org",
         "type": "InternetGatewayDevice",
         "version": 1
       },
       "version": {
         "major": 1,
         "minor": 0
       }
     },
     "gateway_id": 1,
     "stat": null
   }, ...
]
```

----

# /api/upnp/device/online/:gatewayId
## 설명

해당 게이트웨이(:gatewayId)에 연결중인 디바이스의 디스크립터를 가져온다.

## Method

GET

## Parameters

**gatewayId** *required*
원하는 게이트웨이의 아이디를 입력한다.

## Returns

```javascript
[
   {
     "uuid": "fc4ec57e-b051-11db-88f8-0060085db3f6",
     "service_descriptor": {
       "details": {
         "baseURL": null,
         "dlnaCaps": null,
         "dlnaDocs": [],
         "friendlyName": "EFM Networks ipTIME N904NS",
         "manufacturerDetails": {
           "manufacturer": "EFM Networks",
           "manufacturerURI": "http://www.iptime.co.kr"
         },
         "modelDetails": {
           "modelDescription": "EFM Networks ipTIME N904NS",
           "modelName": "ipTIME N904NS",
           "modelNumber": "1",
           "modelURI": "http://www.iptime.co.kr"
         },
         "presentationURI": "http://192.168.0.1/",
         "secProductCaps": null,
         "serialNumber": "12345678",
         "upc": null
       },
       "embeddedDevices": [
         {
            ...
         }
       ],
       "icons": [],
       "identity": {
         "descriptorURL": "http://192.168.0.1:38507/etc/linuxigd/gatedesc.xml",
         "discoveredOnLocalAddress": "10.0.3.15",
         "interfaceMacAddress": null,
         "maxAgeSeconds": 120,
         "udn": {
           "identifierString": "fc4ec57e-b051-11db-88f8-0060085db3f6"
         }
       },
       "services": [
         {
           "controlURI": "/dummy",
           "descriptorURI": "/etc/linuxigd/dummy.xml",
           "eventSubscriptionURI": "/dummy",
           "actions": {},
           "serviceId": {
             "id": "dummy1",
             "namespace": "dummy-com"
           },
           "serviceType": {
             "namespace": "schemas-dummy-com",
             "type": "Dummy",
             "version": 1
           },
           "stateVariables": {}
         }
       ],
       "type": {
         "namespace": "schemas-upnp-org",
         "type": "InternetGatewayDevice",
         "version": 1
       },
       "version": {
         "major": 1,
         "minor": 0
       }
     },
     "gateway_id": 1
   }, ...
]
```

----

# /api/upnp/device/:gatewayId(\\d+)/:deviceUuid
## 설명

해당 게이트웨이(:gatewayId)에 소속된 하나의 디바이스 디스크립터를 가져온다.

## Method

GET

## Header
Authorization : Bearer [ACCESS_CODE]

## Parameters

**gatewayId** *required*
원하는 게이트웨이의 아이디를 입력한다.

**deviceUuid** *required*
원하는 디바이스의 UUID를 입력한다.

## Returns

```javascript
{
 "id": 1,
 "uuid": "fc4ec57e-b051-11db-88f8-0060085db3f6",
 "service_descriptor": {
   "details": {
     "baseURL": null,
     "dlnaCaps": null,
     "dlnaDocs": [],
     "friendlyName": "EFM Networks ipTIME N904NS",
     "manufacturerDetails": {
       "manufacturer": "EFM Networks",
       "manufacturerURI": "http://www.iptime.co.kr"
     },
     "modelDetails": {
       "modelDescription": "EFM Networks ipTIME N904NS",
       "modelName": "ipTIME N904NS",
       "modelNumber": "1",
       "modelURI": "http://www.iptime.co.kr"
     },
     "presentationURI": "http://192.168.0.1/",
     "secProductCaps": null,
     "serialNumber": "12345678",
     "upc": null
   },
   "embeddedDevices": [
     {
        ...
     }
   ],
   "icons": [],
   "identity": {
     "descriptorURL": "http://192.168.0.1:38507/etc/linuxigd/gatedesc.xml",
     "discoveredOnLocalAddress": "10.0.3.15",
     "interfaceMacAddress": null,
     "maxAgeSeconds": 120,
     "udn": {
       "identifierString": "fc4ec57e-b051-11db-88f8-0060085db3f6"
     }
   },
   "services": [
     {
       "controlURI": "/dummy",
       "descriptorURI": "/etc/linuxigd/dummy.xml",
       "eventSubscriptionURI": "/dummy",
       "actions": {},
       "serviceId": {
         "id": "dummy1",
         "namespace": "dummy-com"
       },
       "serviceType": {
         "namespace": "schemas-dummy-com",
         "type": "Dummy",
         "version": 1
       },
       "stateVariables": {}
     }
   ],
   "type": {
     "namespace": "schemas-upnp-org",
     "type": "InternetGatewayDevice",
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
```

----

# /api/upnp/control/:gatewayId(\\d+)/:uuid/*

## 설명 

UPNP디바이스를 제어한다.

## Method

GET

## Parameters

**gatewayId** *required*
디바이스가 속해있는 게이트웨이의 아이디를 넣는다.

**uuid** *required*
디바이스의 UUID를 넣는다.

Payload에 컨트롤할 액션에 대한 파라미터를 넣는다.

예)
```javascript
{
  "NewPortMappingIndex": "0"
}
```

## Returns

```javascript
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
```

----

# /api/upnp/event/device/:gatewayId
## 설명

해당 게이트웨이(:gatewayId)의 모든 디바이스의 최근 변경된 이벤트 정보를 가져온다.

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
    "type": "DeviceAdd",
    "event": null,
    "date": "2014-09-16T02:53:14.000Z",
    "gateway_id": 1,
    "device_id": 1,
    "uuid": "fc4ec57e-b051-11db-88f8-0060085db3f6",
    "service_type": null
  },
  {
    "id": 3,
    "type": "DeviceAdd",
    "event": null,
    "date": "2014-09-16T02:53:26.000Z",
    "gateway_id": 1,
    "device_id": 2,
    "uuid": "0aba9500-00b4-1000-8bb9-78abbb7f02b7",
    "service_type": null
  },
  {
    "id": 4,
    "type": "DeviceAdd",
    "event": null,
    "date": "2014-09-04T06:40:37.000Z",
    "gateway_id": 1,
    "device_id": 3,
    "uuid": "04c4b402-0050-1000-8378-5056bf51503d",
    "service_type": null
  }, ...
]
```

----

# /api/upnp/event/device/:gatewayId/:time
## 설명

해당 게이트웨이(:gatewayId)의 모든 디바이스의 특정 시간(:time) 이후의 변경된 이벤트 정보를 가져온다.

## Method

GET

## Parameters

**gatewayId** *required*
원하는 게이트웨이의 아이디를 입력한다.

**time** *required*
시간을 Long 형태로 입력한다.(ex : Date.now() )

## Returns

```javascript
[
   {
     "id": 422,
     "type": "DeviceAdd",
     "event": null,
     "date": "2014-09-16T02:53:18.000Z",
     "gateway_id": 1,
     "device_id": 40,
     "uuid": "2f402f80-da50-11e1-9b23-00178809e158",
     "service_type": null
   },
   {
     "id": 427,
     "type": "DeviceRemove",
     "event": null,
     "date": "2014-09-16T02:54:59.000Z",
     "gateway_id": 1,
     "device_id": 40,
     "uuid": "2f402f80-da50-11e1-9b23-00178809e158",
     "service_type": null
   }
 ]
```

----

# /api/upnp/event/device/:gatewayId/:deviceUuid
## 설명

해당 게이트웨이(:gatewayId)의 특정 디바이스(:deviceUuid)의 변경된 이벤트 정보를 가져온다.

## Method

GET

## Parameters

**gatewayId** *required*
원하는 게이트웨이의 아이디를 입력한다.

**deviceUuid** *required*
디바이스의 UUID를 입력한다.

## Returns

```javascript
[
   {
     "id": 1,
     "type": "DeviceAdd",
     "event": null,
     "date": "2014-09-16T02:53:14.000Z",
     "gateway_id": 1,
     "device_id": 1,
     "uuid": "fc4ec57e-b051-11db-88f8-0060085db3f6",
     "service_type": null
   },
   {
     "id": 12,
     "type": "DeviceRemove",
     "event": null,
     "date": "2014-09-04T06:42:40.000Z",
     "gateway_id": 1,
     "device_id": 1,
     "uuid": "fc4ec57e-b051-11db-88f8-0060085db3f6",
     "service_type": null
   }
]
```

----

# /api/upnp/event/device/:gatewayId/:deviceUuid/:time
## 설명

해당 게이트웨이(:gatewayId)의 특정 디바이스(:deviceUuid)의 특정 시간(:time) 이후의 변경된 이벤트 정보를 가져온다.

## Method

GET

## Header
Authorization : Bearer [ACCESS_CODE]

## Parameters

**gatewayId** *required*
원하는 게이트웨이의 아이디를 입력한다.

**deviceUuid** *required*
디바이스의 UUID를 입력한다.

**time** *required*
시간을 Long 형태로 입력한다.(ex : Date.now() )

## Returns

```javascript
[
   {
     "id": 1,
     "type": "DeviceAdd",
     "event": null,
     "date": "2014-09-16T02:53:14.000Z",
     "gateway_id": 1,
     "device_id": 1,
     "uuid": "fc4ec57e-b051-11db-88f8-0060085db3f6",
     "service_type": null
   },
   {
     "id": 12,
     "type": "DeviceRemove",
     "event": null,
     "date": "2014-09-04T06:42:40.000Z",
     "gateway_id": 1,
     "device_id": 1,
     "uuid": "fc4ec57e-b051-11db-88f8-0060085db3f6",
     "service_type": null
   }
]
```



