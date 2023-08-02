# getDeviceDescriptor

## 개요 

| Type | Value | Description |
| -----------|-----------|-----------|
| Url | /api/{gatewayID}/getDeviceDescriptor/{uuid} | {gatewayID} : 해당 REST 호출에 대한 게이트웨이 ID<br> {uuid} : Upnp 디바이스의 UUID |
| Method | `GET` |  |
| Parameter | NONE |  |
| Response | 한개의 Upnp Device Descriptor (Model - JSON Object 참조) |  |

게이트웨이에서 연결된 디바이스중  UUID에 해당하는 디바이스 디스크립터를 가져옵니다.

## 예시 

### Requset

GET /SHS/api/8/getDeviceDescriptor/fc4ec57e-b051-11db-88f8-0060085db3f6 HTTP/1.1

### Response

~~~javascript

{
    "details": {
        "baseURL": null,
        "dlnaCaps": null,
        "dlnaDocs": [],
        "friendlyName": "EFM Networks ipTIME N104M",
        "manufacturerDetails": {
            "manufacturer": "EFM Networks",
            "manufacturerURI": "http://www.iptime.co.kr"
        },
        "modelDetails": {
            "modelDescription": "EFM Networks ipTIME N104M",
            "modelName": "ipTIME N104M",
            "modelNumber": "1",
            "modelURI": "http://www.iptime.co.kr"
        },
        "presentationURI": "http://192.168.0.1/",
        "secProductCaps": null,
        "serialNumber": "12345678",
        "upc": null
    },
    "embeddedDevices": [{
        "details": {
            "baseURL": null,
            "dlnaCaps": null,
            "dlnaDocs": [],
            "friendlyName": "WANDevice",
            "manufacturerDetails": {
                "manufacturer": "UPnP",
                "manufacturerURI": "http://www.iptime.co.kr"
            },
            "modelDetails": {
                "modelDescription": "WAN Device",
                "modelName": "WAN Device",
                "modelNumber": "20090617",
                "modelURI": "http://www.iptime.co.kr"
            },
            "presentationURI": null,
            "secProductCaps": null,
            "serialNumber": "12345678",
            "upc": "UPNPD"
        },
        "embeddedDevices": [{
            "details": {
                "baseURL": null,
                "dlnaCaps": null,
                "dlnaDocs": [],
                "friendlyName": "WANConnectionDevice",
                "manufacturerDetails": {
                    "manufacturer": "UPnP",
                    "manufacturerURI": "http://www.iptime.co.kr"
                },
                "modelDetails": {
                    "modelDescription": "UPnP daemon",
                    "modelName": "UPnPd",
                    "modelNumber": "20090617",
                    "modelURI": "http://www.iptime.co.kr"
                },
                "presentationURI": null,
                "secProductCaps": null,
                "serialNumber": "12345678",
                "upc": "UPNPD"
            },
            "embeddedDevices": null,
            "icons": [],
            "identity": {
                "descriptorURL": "http://192.168.0.1:3243/etc/linuxigd/gatedesc.xml",
                "discoveredOnLocalAddress": "192.168.0.9",
                "interfaceMacAddress": null,
                "maxAgeSeconds": 120,
                "udn": {
                    "identifierString": "fc4ec57e-b051-11db-88f8-0060085db3f6"
                }
            },
            "services": [{
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
                    "RequestConnection": {
                        "arguments": [],
                        "inputArguments": [],
                        "name": "RequestConnection",
                        "outputArguments": []
                    },
                    "AddPortMapping": {
                        "arguments": [{
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewRemoteHost",
                            "relatedStateVariableName": "RemoteHost",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewExternalPort",
                            "relatedStateVariableName": "ExternalPort",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewProtocol",
                            "relatedStateVariableName": "PortMappingProtocol",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewInternalPort",
                            "relatedStateVariableName": "InternalPort",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewInternalClient",
                            "relatedStateVariableName": "InternalClient",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewEnabled",
                            "relatedStateVariableName": "PortMappingEnabled",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewPortMappingDescription",
                            "relatedStateVariableName": "PortMappingDescription",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewLeaseDuration",
                            "relatedStateVariableName": "PortMappingLeaseDuration",
                            "returnValue": false
                        }],
                        "inputArguments": [{
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewRemoteHost",
                            "relatedStateVariableName": "RemoteHost",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewExternalPort",
                            "relatedStateVariableName": "ExternalPort",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewProtocol",
                            "relatedStateVariableName": "PortMappingProtocol",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewInternalPort",
                            "relatedStateVariableName": "InternalPort",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewInternalClient",
                            "relatedStateVariableName": "InternalClient",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewEnabled",
                            "relatedStateVariableName": "PortMappingEnabled",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewPortMappingDescription",
                            "relatedStateVariableName": "PortMappingDescription",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewLeaseDuration",
                            "relatedStateVariableName": "PortMappingLeaseDuration",
                            "returnValue": false
                        }],
                        "name": "AddPortMapping",
                        "outputArguments": []
                    },
                    "SetConnectionType": {
                        "arguments": [{
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewConnectionType",
                            "relatedStateVariableName": "ConnectionType",
                            "returnValue": false
                        }],
                        "inputArguments": [{
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewConnectionType",
                            "relatedStateVariableName": "ConnectionType",
                            "returnValue": false
                        }],
                        "name": "SetConnectionType",
                        "outputArguments": []
                    },
                    "GetSpecificPortMappingEntry": {
                        "arguments": [{
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewRemoteHost",
                            "relatedStateVariableName": "RemoteHost",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewExternalPort",
                            "relatedStateVariableName": "ExternalPort",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewProtocol",
                            "relatedStateVariableName": "PortMappingProtocol",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewInternalPort",
                            "relatedStateVariableName": "InternalPort",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewInternalClient",
                            "relatedStateVariableName": "InternalClient",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewEnabled",
                            "relatedStateVariableName": "PortMappingEnabled",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewPortMappingDescription",
                            "relatedStateVariableName": "PortMappingDescription",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewLeaseDuration",
                            "relatedStateVariableName": "PortMappingLeaseDuration",
                            "returnValue": false
                        }],
                        "inputArguments": [{
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewRemoteHost",
                            "relatedStateVariableName": "RemoteHost",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewExternalPort",
                            "relatedStateVariableName": "ExternalPort",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewProtocol",
                            "relatedStateVariableName": "PortMappingProtocol",
                            "returnValue": false
                        }],
                        "name": "GetSpecificPortMappingEntry",
                        "outputArguments": [{
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewInternalPort",
                            "relatedStateVariableName": "InternalPort",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewInternalClient",
                            "relatedStateVariableName": "InternalClient",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewEnabled",
                            "relatedStateVariableName": "PortMappingEnabled",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewPortMappingDescription",
                            "relatedStateVariableName": "PortMappingDescription",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewLeaseDuration",
                            "relatedStateVariableName": "PortMappingLeaseDuration",
                            "returnValue": false
                        }]
                    },
                    "DeletePortMapping": {
                        "arguments": [{
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewRemoteHost",
                            "relatedStateVariableName": "RemoteHost",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewExternalPort",
                            "relatedStateVariableName": "ExternalPort",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewProtocol",
                            "relatedStateVariableName": "PortMappingProtocol",
                            "returnValue": false
                        }],
                        "inputArguments": [{
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewRemoteHost",
                            "relatedStateVariableName": "RemoteHost",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewExternalPort",
                            "relatedStateVariableName": "ExternalPort",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewProtocol",
                            "relatedStateVariableName": "PortMappingProtocol",
                            "returnValue": false
                        }],
                        "name": "DeletePortMapping",
                        "outputArguments": []
                    },
                    "GetGenericPortMappingEntry": {
                        "arguments": [{
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewPortMappingIndex",
                            "relatedStateVariableName": "PortMappingNumberOfEntries",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewRemoteHost",
                            "relatedStateVariableName": "RemoteHost",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewExternalPort",
                            "relatedStateVariableName": "ExternalPort",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewProtocol",
                            "relatedStateVariableName": "PortMappingProtocol",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewInternalPort",
                            "relatedStateVariableName": "InternalPort",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewInternalClient",
                            "relatedStateVariableName": "InternalClient",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewEnabled",
                            "relatedStateVariableName": "PortMappingEnabled",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewPortMappingDescription",
                            "relatedStateVariableName": "PortMappingDescription",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewLeaseDuration",
                            "relatedStateVariableName": "PortMappingLeaseDuration",
                            "returnValue": false
                        }],
                        "inputArguments": [{
                            "aliases": [],
                            "direction": "IN",
                            "name": "NewPortMappingIndex",
                            "relatedStateVariableName": "PortMappingNumberOfEntries",
                            "returnValue": false
                        }],
                        "name": "GetGenericPortMappingEntry",
                        "outputArguments": [{
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewRemoteHost",
                            "relatedStateVariableName": "RemoteHost",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewExternalPort",
                            "relatedStateVariableName": "ExternalPort",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewProtocol",
                            "relatedStateVariableName": "PortMappingProtocol",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewInternalPort",
                            "relatedStateVariableName": "InternalPort",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewInternalClient",
                            "relatedStateVariableName": "InternalClient",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewEnabled",
                            "relatedStateVariableName": "PortMappingEnabled",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewPortMappingDescription",
                            "relatedStateVariableName": "PortMappingDescription",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewLeaseDuration",
                            "relatedStateVariableName": "PortMappingLeaseDuration",
                            "returnValue": false
                        }]
                    },
                    "GetNATRSIPStatus": {
                        "arguments": [{
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewRSIPAvailable",
                            "relatedStateVariableName": "RSIPAvailable",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewNATEnabled",
                            "relatedStateVariableName": "NATEnabled",
                            "returnValue": false
                        }],
                        "inputArguments": [],
                        "name": "GetNATRSIPStatus",
                        "outputArguments": [{
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewRSIPAvailable",
                            "relatedStateVariableName": "RSIPAvailable",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewNATEnabled",
                            "relatedStateVariableName": "NATEnabled",
                            "returnValue": false
                        }]
                    },
                    "ForceTermination": {
                        "arguments": [],
                        "inputArguments": [],
                        "name": "ForceTermination",
                        "outputArguments": []
                    },
                    "GetConnectionTypeInfo": {
                        "arguments": [{
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewConnectionType",
                            "relatedStateVariableName": "ConnectionType",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewPossibleConnectionTypes",
                            "relatedStateVariableName": "PossibleConnectionTypes",
                            "returnValue": false
                        }],
                        "inputArguments": [],
                        "name": "GetConnectionTypeInfo",
                        "outputArguments": [{
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewConnectionType",
                            "relatedStateVariableName": "ConnectionType",
                            "returnValue": false
                        }, {
                            "aliases": [],
                            "direction": "OUT",
                            "name": "NewPossibleConnectionTypes",
                            "relatedStateVariableName": "PossibleConnectionTypes",
                            "returnValue": false
                        }]
                    }
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
                    "PortMappingEnabled": {
                        "eventDetails": {
                            "eventMaximumRateMilliseconds": 0,
                            "eventMinimumDelta": 0,
                            "sendEvents": false
                        },
                        "name": "PortMappingEnabled",
                        "type": {
                            "allowedValueRange": null,
                            "allowedValues": null,
                            "datatype": {
                                "builtin": "BOOLEAN"
                            },
                            "defaultValue": null
                        }
                    },
                    "ConnectionType": {
                        "eventDetails": {
                            "eventMaximumRateMilliseconds": 0,
                            "eventMinimumDelta": 0,
                            "sendEvents": false
                        },
                        "name": "ConnectionType",
                        "type": {
                            "allowedValueRange": null,
                            "allowedValues": null,
                            "datatype": {
                                "builtin": "STRING"
                            },
                            "defaultValue": null
                        }
                    },
                    "InternalClient": {
                        "eventDetails": {
                            "eventMaximumRateMilliseconds": 0,
                            "eventMinimumDelta": 0,
                            "sendEvents": false
                        },
                        "name": "InternalClient",
                        "type": {
                            "allowedValueRange": null,
                            "allowedValues": null,
                            "datatype": {
                                "builtin": "STRING"
                            },
                            "defaultValue": null
                        }
                    },
                    "PortMappingLeaseDuration": {
                        "eventDetails": {
                            "eventMaximumRateMilliseconds": 0,
                            "eventMinimumDelta": 0,
                            "sendEvents": false
                        },
                        "name": "PortMappingLeaseDuration",
                        "type": {
                            "allowedValueRange": null,
                            "allowedValues": null,
                            "datatype": {
                                "builtin": "UI4"
                            },
                            "defaultValue": null
                        }
                    },
                    "PortMappingNumberOfEntries": {
                        "eventDetails": {
                            "eventMaximumRateMilliseconds": 0,
                            "eventMinimumDelta": 0,
                            "sendEvents": false
                        },
                        "name": "PortMappingNumberOfEntries",
                        "type": {
                            "allowedValueRange": null,
                            "allowedValues": null,
                            "datatype": {
                                "builtin": "UI2"
                            },
                            "defaultValue": null
                        }
                    },
                    "LastConnectionError": {
                        "eventDetails": {
                            "eventMaximumRateMilliseconds": 0,
                            "eventMinimumDelta": 0,
                            "sendEvents": false
                        },
                        "name": "LastConnectionError",
                        "type": {
                            "allowedValueRange": null,
                            "allowedValues": ["ERROR_NONE"],
                            "datatype": {
                                "builtin": "STRING"
                            },
                            "defaultValue": null
                        }
                    },
                    "PortMappingDescription": {
                        "eventDetails": {
                            "eventMaximumRateMilliseconds": 0,
                            "eventMinimumDelta": 0,
                            "sendEvents": false
                        },
                        "name": "PortMappingDescription",
                        "type": {
                            "allowedValueRange": null,
                            "allowedValues": null,
                            "datatype": {
                                "builtin": "STRING"
                            },
                            "defaultValue": null
                        }
                    },
                    "ExternalPort": {
                        "eventDetails": {
                            "eventMaximumRateMilliseconds": 0,
                            "eventMinimumDelta": 0,
                            "sendEvents": false
                        },
                        "name": "ExternalPort",
                        "type": {
                            "allowedValueRange": null,
                            "allowedValues": null,
                            "datatype": {
                                "builtin": "UI2"
                            },
                            "defaultValue": null
                        }
                    },
                    "InternalPort": {
                        "eventDetails": {
                            "eventMaximumRateMilliseconds": 0,
                            "eventMinimumDelta": 0,
                            "sendEvents": false
                        },
                        "name": "InternalPort",
                        "type": {
                            "allowedValueRange": null,
                            "allowedValues": null,
                            "datatype": {
                                "builtin": "UI2"
                            },
                            "defaultValue": null
                        }
                    },
                    "PossibleConnectionTypes": {
                        "eventDetails": {
                            "eventMaximumRateMilliseconds": 0,
                            "eventMinimumDelta": 0,
                            "sendEvents": false
                        },
                        "name": "PossibleConnectionTypes",
                        "type": {
                            "allowedValueRange": null,
                            "allowedValues": ["Unconfigured", "IP_Routed", "IP_Bridged"],
                            "datatype": {
                                "builtin": "STRING"
                            },
                            "defaultValue": null
                        }
                    },
                    "RemoteHost": {
                        "eventDetails": {
                            "eventMaximumRateMilliseconds": 0,
                            "eventMinimumDelta": 0,
                            "sendEvents": false
                        },
                        "name": "RemoteHost",
                        "type": {
                            "allowedValueRange": null,
                            "allowedValues": null,
                            "datatype": {
                                "builtin": "STRING"
                            },
                            "defaultValue": null
                        }
                    },
                    "ConnectionStatus": {
                        "eventDetails": {
                            "eventMaximumRateMilliseconds": 0,
                            "eventMinimumDelta": 0,
                            "sendEvents": false
                        },
                        "name": "ConnectionStatus",
                        "type": {
                            "allowedValueRange": null,
                            "allowedValues": ["Unconfigured", "Connecting", "Connected", "PendingDisconnect", "Disconnecting", "Disconnected"],
                            "datatype": {
                                "builtin": "STRING"
                            },
                            "defaultValue": null
                        }
                    },
                    "ExternalIPAddress": {
                        "eventDetails": {
                            "eventMaximumRateMilliseconds": 0,
                            "eventMinimumDelta": 0,
                            "sendEvents": false
                        },
                        "name": "ExternalIPAddress",
                        "type": {
                            "allowedValueRange": null,
                            "allowedValues": null,
                            "datatype": {
                                "builtin": "STRING"
                            },
                            "defaultValue": null
                        }
                    },
                    "NATEnabled": {
                        "eventDetails": {
                            "eventMaximumRateMilliseconds": 0,
                            "eventMinimumDelta": 0,
                            "sendEvents": false
                        },
                        "name": "NATEnabled",
                        "type": {
                            "allowedValueRange": null,
                            "allowedValues": null,
                            "datatype": {
                                "builtin": "BOOLEAN"
                            },
                            "defaultValue": null
                        }
                    }
                }
            }],
            "type": {
                "namespace": "schemas-upnp-org",
                "type": "WANConnectionDevice",
                "version": 1
            },
            "version": {
                "major": 1,
                "minor": 0
            }
        }],
        "icons": [],
        "identity": {
            "descriptorURL": "http://192.168.0.1:3243/etc/linuxigd/gatedesc.xml",
            "discoveredOnLocalAddress": "192.168.0.9",
            "interfaceMacAddress": null,
            "maxAgeSeconds": 120,
            "udn": {
                "identifierString": "fc4ec57e-b051-11db-88f8-0060085db3f6"
            }
        },
        "services": [{
            "controlURI": "/etc/linuxigd/gateicfgSCPD.ctl",
            "descriptorURI": "/etc/linuxigd/gateicfgSCPD.xml",
            "eventSubscriptionURI": "/etc/linuxigd/gateicfgSCPD.evt",
            "actions": {
                "GetCommonLinkProperties": {
                    "arguments": [{
                        "aliases": [],
                        "direction": "OUT",
                        "name": "NewWANAccessType",
                        "relatedStateVariableName": "WANAccessType",
                        "returnValue": false
                    }, {
                        "aliases": [],
                        "direction": "OUT",
                        "name": "NewLayer1UpstreamMaxBitRate",
                        "relatedStateVariableName": "Layer1UpstreamMaxBitRate",
                        "returnValue": false
                    }, {
                        "aliases": [],
                        "direction": "OUT",
                        "name": "NewLayer1DownstreamMaxBitRate",
                        "relatedStateVariableName": "Layer1DownstreamMaxBitRate",
                        "returnValue": false
                    }, {
                        "aliases": [],
                        "direction": "OUT",
                        "name": "NewPhysicalLinkStatus",
                        "relatedStateVariableName": "PhysicalLinkStatus",
                        "returnValue": false
                    }],
                    "inputArguments": [],
                    "name": "GetCommonLinkProperties",
                    "outputArguments": [{
                        "aliases": [],
                        "direction": "OUT",
                        "name": "NewWANAccessType",
                        "relatedStateVariableName": "WANAccessType",
                        "returnValue": false
                    }, {
                        "aliases": [],
                        "direction": "OUT",
                        "name": "NewLayer1UpstreamMaxBitRate",
                        "relatedStateVariableName": "Layer1UpstreamMaxBitRate",
                        "returnValue": false
                    }, {
                        "aliases": [],
                        "direction": "OUT",
                        "name": "NewLayer1DownstreamMaxBitRate",
                        "relatedStateVariableName": "Layer1DownstreamMaxBitRate",
                        "returnValue": false
                    }, {
                        "aliases": [],
                        "direction": "OUT",
                        "name": "NewPhysicalLinkStatus",
                        "relatedStateVariableName": "PhysicalLinkStatus",
                        "returnValue": false
                    }]
                }
            },
            "serviceId": {
                "id": "WANCommonIFC1",
                "namespace": "upnp-org"
            },
            "serviceType": {
                "namespace": "schemas-upnp-org",
                "type": "WANCommonInterfaceConfig",
                "version": 1
            },
            "stateVariables": {
                "Layer1UpstreamMaxBitRate": {
                    "eventDetails": {
                        "eventMaximumRateMilliseconds": 0,
                        "eventMinimumDelta": 0,
                        "sendEvents": false
                    },
                    "name": "Layer1UpstreamMaxBitRate",
                    "type": {
                        "allowedValueRange": null,
                        "allowedValues": null,
                        "datatype": {
                            "builtin": "UI4"
                        },
                        "defaultValue": null
                    }
                },
                "Layer1DownstreamMaxBitRate": {
                    "eventDetails": {
                        "eventMaximumRateMilliseconds": 0,
                        "eventMinimumDelta": 0,
                        "sendEvents": false
                    },
                    "name": "Layer1DownstreamMaxBitRate",
                    "type": {
                        "allowedValueRange": null,
                        "allowedValues": null,
                        "datatype": {
                            "builtin": "UI4"
                        },
                        "defaultValue": null
                    }
                },
                "WANAccessType": {
                    "eventDetails": {
                        "eventMaximumRateMilliseconds": 0,
                        "eventMinimumDelta": 0,
                        "sendEvents": false
                    },
                    "name": "WANAccessType",
                    "type": {
                        "allowedValueRange": null,
                        "allowedValues": ["DSL", "POTS", "Cable", "Ethernet"],
                        "datatype": {
                            "builtin": "STRING"
                        },
                        "defaultValue": null
                    }
                },
                "PhysicalLinkStatus": {
                    "eventDetails": {
                        "eventMaximumRateMilliseconds": 0,
                        "eventMinimumDelta": 0,
                        "sendEvents": false
                    },
                    "name": "PhysicalLinkStatus",
                    "type": {
                        "allowedValueRange": null,
                        "allowedValues": ["Up", "Down", "Initializing", "Unavailable"],
                        "datatype": {
                            "builtin": "STRING"
                        },
                        "defaultValue": null
                    }
                }
            }
        }],
        "type": {
            "namespace": "schemas-upnp-org",
            "type": "WANDevice",
            "version": 1
        },
        "version": {
            "major": 1,
            "minor": 0
        }
    }],
    "icons": [],
    "identity": {
        "descriptorURL": "http://192.168.0.1:3243/etc/linuxigd/gatedesc.xml",
        "discoveredOnLocalAddress": "192.168.0.9",
        "interfaceMacAddress": null,
        "maxAgeSeconds": 120,
        "udn": {
            "identifierString": "fc4ec57e-b051-11db-88f8-0060085db3f6"
        }
    },
    "services": [{
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
    }],
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

~~~
