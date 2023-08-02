# Upnp Device Descriptor

## 개요

Upnp 서비스가 제공하는 XML형식의 Descriptor와 매칭이 되는 자바스크립트 객체입니다. 
하나의 디바이스 디스크립터는 embeddedDevices 배열 안에서 여러개의 서브 디바이스 디스크립터를 가질 수 있습니다.
하나의 디바이스 디스크립터는 services 배열 안에서 여러개의 서비스 디스크립터를 가질 수 있습니다.

## Example

~~~~javascript

  {
    "details": {
      "baseURL": null,
      "dlnaCaps": null,
      "dlnaDocs": [
        
      ],
      "friendlyName": "EFM Networks ipTIME N8004R",
      "manufacturerDetails": {
        "manufacturer": "EFM Networks",
        "manufacturerURI": "http:\/\/www.iptime.co.kr"
      },
      "modelDetails": {
        "modelDescription": "EFM Networks ipTIME N8004R",
        "modelName": "ipTIME N8004R",
        "modelNumber": "1",
        "modelURI": "http:\/\/www.iptime.co.kr"
      },
      "presentationURI": "http:\/\/192.168.0.1\/",
      "secProductCaps": null,
      "serialNumber": "12345678",
      "upc": null
    },
    "embeddedDevices": [
      {
      	...
      }
    ],
    "icons": [
      
    ],
    "identity": {
      "descriptorURL": "http:\/\/192.168.0.1:56450\/etc\/linuxigd\/gatedesc.xml",
      "discoveredOnLocalAddress": "192.168.0.100",
      "interfaceMacAddress": null,
      "maxAgeSeconds": 120,
      "udn": {
        "identifierString": "fc4ec57e-b051-11db-88f8-0060085db3f6"
      }
    },
    "services": [
      {
        "controlURI": "\/dummy",
        "descriptorURI": "\/etc\/linuxigd\/dummy.xml",
        "eventSubscriptionURI": "\/dummy",
        "actions": {
          
        },
        "serviceId": {
          "id": "dummy1",
          "namespace": "dummy-com"
        },
        "serviceType": {
          "namespace": "schemas-dummy-com",
          "type": "Dummy",
          "version": 1
        },
        "stateVariables": {
          
        }
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
  }

~~~~

### Upnp Service Descriptor
-------------------------

서비스 디스크립터는 하나의 디바이스 디스크립터 안에 여러개 존재할 수 있습니다. 
actions 배열에 있는 데이터를 참고해서 디바이스를 제어 할 수 있습니다.

##### Example

~~~~javascript

{
    "controlURI": "/etc/linuxigd/gateconnSCPD.ctl",
    "descriptorURI": "/etc/linuxigd/gateconnSCPD.xml",
    "eventSubscriptionURI": "/etc/linuxigd/gateconnSCPD.evt",
    "actions": {
        "GetStatusInfo": {
            "arguments": [{
                "aliases": [],
                "direction": "OUT",
                "name": "NewConnectionStatus",
                "relatedStateVariableName": "ConnectionStatus",
                "returnValue": false
            }, {
                "aliases": [],
                "direction": "OUT",
                "name": "NewLastConnectionError",
                "relatedStateVariableName": "LastConnectionError",
                "returnValue": false
            }, {
                "aliases": [],
                "direction": "OUT",
                "name": "NewUptime",
                "relatedStateVariableName": "Uptime",
                "returnValue": false
            }],
            "inputArguments": [],
            "name": "GetStatusInfo",
            "outputArguments": [{
                "aliases": [],
                "direction": "OUT",
                "name": "NewConnectionStatus",
                "relatedStateVariableName": "ConnectionStatus",
                "returnValue": false
            }, {
                "aliases": [],
                "direction": "OUT",
                "name": "NewLastConnectionError",
                "relatedStateVariableName": "LastConnectionError",
                "returnValue": false
            }, {
                "aliases": [],
                "direction": "OUT",
                "name": "NewUptime",
                "relatedStateVariableName": "Uptime",
                "returnValue": false
            }]
        },
        "GetExternalIPAddress": {
            "arguments": [{
                "aliases": [],
                "direction": "OUT",
                "name": "NewExternalIPAddress",
                "relatedStateVariableName": "ExternalIPAddress",
                "returnValue": false
            }],
            "inputArguments": [],
            "name": "GetExternalIPAddress",
            "outputArguments": [{
                "aliases": [],
                "direction": "OUT",
                "name": "NewExternalIPAddress",
                "relatedStateVariableName": "ExternalIPAddress",
                "returnValue": false
            }]
        },
        ...
    },
    "serviceId": {
        "id": "WANIPConn1",
        "namespace": "upnp-org"
    },
    "serviceType": {
        "namespace": "schemas-upnp-org",
        "type": "WANIPConnection",
        "version": 1
    },
    "stateVariables": {
        "PortMappingProtocol": {
            "eventDetails": {
                "eventMaximumRateMilliseconds": 0,
                "eventMinimumDelta": 0,
                "sendEvents": false
            },
            "name": "PortMappingProtocol",
            "type": {
                "allowedValueRange": null,
                "allowedValues": ["TCP", "UDP"],
                "datatype": {
                    "builtin": "STRING"
                },
                "defaultValue": null
            }
        },
        "Uptime": {
            "eventDetails": {
                "eventMaximumRateMilliseconds": 0,
                "eventMinimumDelta": 0,
                "sendEvents": false
            },
            "name": "Uptime",
            "type": {
                "allowedValueRange": null,
                "allowedValues": null,
                "datatype": {
                    "builtin": "UI4"
                },
                "defaultValue": null
            }
        },
        "RSIPAvailable": {
            "eventDetails": {
                "eventMaximumRateMilliseconds": 0,
                "eventMinimumDelta": 0,
                "sendEvents": false
            },
            "name": "RSIPAvailable",
            "type": {
                "allowedValueRange": null,
                "allowedValues": null,
                "datatype": {
                    "builtin": "BOOLEAN"
                },
                "defaultValue": null
            }
        },
        ...
    }
}

~~~~

### Upnp Action Response
-------------------------
  
Upnp 디바이스에 제어 메시지를 보냈을 때(Action)에 대한 응답 객체입니다.

##### Example

~~~~javascript

{
    "NewRemoteHost": {
        "argument": {
            "aliases": [],
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
            "aliases": [],
            "direction": "OUT",
            "name": "NewExternalPort",
            "relatedStateVariableName": "ExternalPort",
            "returnValue": false
        },
        "datatype": {
            "builtin": "UI2"
        },
        "value": {
            "value": 8123
        }
    },
    "NewProtocol": {
        "argument": {
            "aliases": [],
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
            "aliases": [],
            "direction": "OUT",
            "name": "NewInternalPort",
            "relatedStateVariableName": "InternalPort",
            "returnValue": false
        },
        "datatype": {
            "builtin": "UI2"
        },
        "value": {
            "value": 8123
        }
    },
    "NewInternalClient": {
        "argument": {
            "aliases": [],
            "direction": "OUT",
            "name": "NewInternalClient",
            "relatedStateVariableName": "InternalClient",
            "returnValue": false
        },
        "datatype": {
            "builtin": "STRING"
        },
        "value": "127.0.0.1"
    },
    "NewEnabled": {
        "argument": {
            "aliases": [],
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
            "aliases": [],
            "direction": "OUT",
            "name": "NewPortMappingDescription",
            "relatedStateVariableName": "PortMappingDescription",
            "returnValue": false
        },
        "datatype": {
            "builtin": "STRING"
        },
        "value": "HHC Port Mapping"
    },
    "NewLeaseDuration": {
        "argument": {
            "aliases": [],
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

~~~~

### Upnp Event
-------------------------
  
Upnp 디바이스에서 상태가 변경된 정보를 담고있습니다.

##### Example

~~~~javascript
{
  "event": [
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
  "time": 1390462617423
}
~~~~