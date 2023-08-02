<?php
//-----------------------------------------------------------------------------
// JPark @ KETI, 2018
//-----------------------------------------------------------------------------
//include('session.php');
?>

<!doctype html>
<html>
<head>
    <?
        include "inc_header.php";
    ?>
    
<script>

//-----------------------------------------------------------------------------
// IoT connection example through MQTT
//-----------------------------------------------------------------------------
var clientMQTT;
//var form = document.getElementById("tutorial");
  
function doConnectMQTT() {
    var MQTT_SERVER = "ketihhc.iptime.org"
    var MQTT_WS_PORT = 1884;

    clientMQTT = new Paho.MQTT.Client(MQTT_SERVER, MQTT_WS_PORT, "ClientId");
    clientMQTT.onConnect = onConnectMQTT;
    clientMQTT.onMessageArrived = onMessageArrivedMQTT;
    clientMQTT.onConnectionLost = onConnectionLostMQTT;
    clientMQTT.connect({onSuccess:onConnectMQTT});
    console.log("[+] mqtt server connected");
}

function doSubscribeMQTT(dstName) {
    //clientMQTT.subscribe("/E2E_MQTT_SAMPLE");
    clientMQTT.subscribe(dstName);
    console.log("[+] mqtt topic subscribe");
}
  
function doSendMQTT(dstName, msg) {
    message = new Paho.MQTT.Message(msg);
    //message.destinationName = "/E2E_IOT_SAMPLE";
    message.destinationName = dstName;
    clientMQTT.send(message);
    console.log("[+] doSend, dst:" + message.destinationName);
}

function doDisconnectMQTT() {
    clientMQTT.disconnect();
    console.log("[+] disconnected ");
}
  
// Web Messaging API callbacks
function onConnectMQTT() {
    var form = document.getElementById("statuslabel3_id");
    //form.connected.checked= true;
}
  
function onConnectionLostMQTT(responseObject) {
    var form = document.getElementById("statuslabel3_id");
    //form.connected.checked= false;
    if (responseObject.errorCode !== 0)
        alert(clientMQTT.clientId+"\n"+responseObject.errorCode);
}
  
function onMessageArrivedMQTT(message) {
    var form = document.getElementById("statuslabel3_id");
    form.receiveMsg.value = message.payloadString;
}


//-----------------------------------------------------------------------------
// 클라이언트 인증처리부
//-----------------------------------------------------------------------------

// JSON Data example
/*
            var json_source = [
                {"model" : "Iphone 18", "name" : "iOS", "share" : 57.56},
                {"model" : "Nexus 23", "name" : "Android", "share" : 24.66},
                {"model" : "Tom-tom", "name" : "Java ME", "share" : 10.72},
                {"model" : "Nokia 66610", "name" : "Symbian", "share" : 2.49},
                {"model" : "Blackberry", "name" : "Blackberry", "share" : 2.26},
                {"model" : "Lumia", "name" : "Windows Phone", "share" : 1.33}
            ];
            var options = {
                source: json_source,
                rowClass: "classy",
                callback: function(){
                    //alert("Table generated!");
                }
            };
*/

function CheckValidation(smartdeviceinfo_id, sn_id, srcclientkey_id) {
   
    this.init = function() {
    }
    
    this.getkey = function() {
        this.key_smartdevicinfo = localStorage.getItem("key_smartdevicinfo");
        this.key_sn = localStorage.getItem("key_sn");
        this.key_srcclientkey = localStorage.getItem("key_srcclientkey");
        
		$('#'+smartdeviceinfo_id).val(this.key_smartdevicinfo);
		$('#'+sn_id).val(this.key_sn);
		$('#'+srcclientkey_id).val(this.key_srcclientkey);
        
        return this.key_smartdevicinfo+this.key_sn+this.key_srcclientkey;
	}

    this.genclientkey_basic = function(clientinfo) {
        //this.clientkey = SHA256(clientinfo);
        this.clientkey = sha1(clientinfo);
        return this.clientkey;
    }
        
    this.geniotkey_basic = function(info) {
        //this.iotkey = SHA256(info);
        this.iotkey = sha1(info);
        return this.iotkey;
    }
    
    this.genclientkey_ttl = function(clientinfo) {
        var d = new Date();
        var n = d.getMinutes();
        var key;
        console.info(n);
        for(var i=0;i<n;i++) {
            //key = SHA256(clientinfo);
            key = sha1(clientinfo);
        }
        
        this.clientkey = key;
        return key;
    }
	
    this.send = function(url, callback_success) {
		$.ajax({
			url: url,
			headers: {"KETI-Token": this.clientkey},
            contentType: 'application/json; charset=utf-8',
            success: function (result) {
               callback_success(JSON.parse(result));
            }
		});
	}
    
    this.clientkey = "";
}

function EventHandler(
    smartdeviceinfo_id, 
    sn_id, 
    srcclientkey_id, 
    clientinfo_id, 
    clientkey_id, 
    statuslabel1_id,
    statuslabel2_id,
    randval_id,
    clientinfo4iot_id,
    iotkey_id,
) {
    var chkvalid = new CheckValidation(smartdeviceinfo_id, sn_id, srcclientkey_id);
    
    this.init = function() {
        
        doConnectMQTT()
        
        chkvalid.getkey();
        this.genclientkey_basic();
        
        // Show status
        this.textval = "<b> <font color='orange'> 무결성검증키를 생성했습니다. 전송하기를 수행하십시요. </font> </b>";
        $('#'+statuslabel1_id).html(this.textval);
        
        // Pre-existing Table
        $("#iotDeviceListTable").jsonTable({
            //head : ['Name','Serial Number','Image', 'Create', 'Updated'],
            head : ['sensor_name', 'mqtt_topicid', 'sensor_sn(디버깅용)'],
            json : ['sensor_name', 'mqtt_topicid', 'sensor_sn']
        });        
        $("#iotAuthDeviceListTable").jsonTable({
            //head : ['Name','Serial Number','Image', 'Create', 'Updated'],
            head : ['sensor_name', 'mqtt_topicid', 'sensor_sn(디버깅용)', '센서값 보기'],
            json : ['sensor_name', 'mqtt_topicid', 'sensor_sn', 'go_sensor']
        });
    }
    
    this.genclientkey_basic = function() {
        // Read updated information
        this.key_smartdevicinfo = $('#'+smartdeviceinfo_id).val();
        this.key_sn = $('#'+sn_id).val();
        this.key_srcclientkey = $('#'+srcclientkey_id).val();
        
        // Merge
        this.clientinfo = this.key_smartdevicinfo+this.key_sn+this.key_srcclientkey;
        
        // Generate a validation key
        this.clientkey = chkvalid.genclientkey_basic(this.clientinfo);
        
        // Show validation key
        $('#'+clientinfo_id).html(this.clientinfo);
        $('#'+clientkey_id).html(this.clientkey);
    }
    
    this.geniotkey_basic = function() {
        
        // Read updated information
        this.key_smartdevicinfo = $('#'+smartdeviceinfo_id).val();
        this.key_sn = $('#'+sn_id).val();
        //[ignore] this.key_srcclientkey = $('#'+srcclientkey_id).val();
        this.key_randval = $('#'+randval_id).val();
        
        // Merge
        this.clientinfo4iot = 
            this.key_smartdevicinfo+this.key_sn
            + this.key_randval;
        
        // Generate a iot validation key
        this.iotkey = chkvalid.geniotkey_basic(this.clientinfo4iot);
        
        // Show validation key
        $('#'+clientinfo4iot_id).html(this.clientinfo4iot);
        $('#'+iotkey_id).html(this.iotkey);
    }
 
	this.changed = function() {
        this.genclientkey_basic();
        
        // Show validation key
        //$('#'+clientinfo_id).html(this.clientinfo);
        $('#'+clientkey_id).html(this.clientkey);
        
        // Show status
        $('#'+statuslabel1_id).html("<b> <font color='orange'> 무결성검증키를 다시 생성했습니다. 전송하기를 수행하십시요. </font> </b>");
    }
    
	this.do_auth = function() {
        this.genclientkey_basic();
        this.geniotkey_basic();
        
        chkvalid.send("rest/checkvalid_sd2ca.php", function(res) {
            if( res.is_valid ) {
                // Read updated information
                this.key_smartdevicinfo = $('#'+smartdeviceinfo_id).val();
                this.key_sn = $('#'+sn_id).val();
                //[ignore] this.key_srcclientkey = $('#'+srcclientkey_id).val();
                this.key_randval = res.randval;
        
                // Merge
                this.clientinfo4iot = this.key_smartdevicinfo+this.key_sn+this.key_randval;
        
                // Generate a iot validation key
                this.iotkey = chkvalid.geniotkey_basic(this.clientinfo4iot);
        
                // Show
                $('#'+statuslabel1_id).html("<b> <font color='blue'> 인증성공 </font> </b>");
                $('#'+statuslabel2_id).html("<b> <font color='blue'> 스마트단말 인증 처리 완료되었습니다. 정보를 확인해 주십시요. </font></b>");
                $('#'+randval_id).html(res.randval);
                this.v = this.clientinfo4iot+this.key_randval
                this.iotkey = chkvalid.geniotkey_basic(this.v);
                $('#'+clientinfo4iot_id).html(this.v);
                $('#'+iotkey_id).html(this.iotkey);
                
                // Iot devices for a smart device
                json_source =JSON.parse(res.iotdevices);
                var opt = {
                    source: json_source,
                    rowClass: "classy",
                    callback: function(){
                        console.info('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>')
                        //console.info(json_source); // [DEBUG]
                        json_source.forEach(function(element, i) {
                            
                            console.log(element.mqtt_topicid + ' :: ' + this.key_randval + ' :: ' + this.iotkey + ':' +  i);
                            
                            var obj = {"authkey": this.iotkey, "randnum": this.key_randval}
                            
                            var myJSON = JSON.stringify(obj);
                            
                            doSendMQTT(element.mqtt_topicid, myJSON);
                        });
                        
                        console.info('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>')
                    }
                };
                $("#iotDeviceListTable").jsonTableUpdate(opt);
            }
            else{
                $('#'+statuslabel1_id).html("<b> <font color='red'> 인증실패 </font> </b>");
                $('#'+statuslabel2_id).html("<b> <font color='red'> 스마트단말 인증안됨 </font></b>");
                $('#'+randval_id).html("---");
                $('#'+clientinfo4iot_id).html("---");
                $('#'+iotkey_id).html("---");
                
                // clear iot devices
                var opt = {
                    source: [],
                    rowClass: "classy",
                    callback: function(){
                        console.info("null"); // [DEBUG]
                    }
                };
                $("#iotDeviceListTable").jsonTableUpdate(opt);
            }
            console.info(res); // [DEBUG]
        });
    }

	this.get_authiots = function() {
        
        chkvalid.send("rest/get_authiots.php", function(res) {
            if( res.is_valid ) {
                // Iot devices for a smart device
                json_source =JSON.parse(res.iotdevices);
                var opt = {
                    source: json_source,
                    rowClass: "classy",
                    callback: function(){
                        console.info('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>')
                        json_source.forEach(function(element, i) {
                            console.log(element.mqtt_topicid + ':::' + this.iotkey + ':' +  i);
                        });
                        
                        console.info('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>')
                    }
                };
                $("#iotAuthDeviceListTable").jsonTableUpdate(opt);
            }
            else{
                // clear iot devices
                var opt = {
                    source: [],
                    rowClass: "classy",
                    callback: function(){
                        console.info("null"); // [DEBUG]
                    }
                };
                $("#iotAuthDeviceListTable").jsonTableUpdate(opt);
            }
            console.info(res); // [DEBUG]
        });
    }    
}

var e = new EventHandler(
    'smartdeviceinfo_id',
    'sn_id',
    'srcclientkey_id',
    'clientinfo_id',
    'clientkey_id',
    'statuslabel1_id',
    'statuslabel2_id',
    'randval_id',
    'clientinfo4iot_id',
    'iotkey_id',
);
</script>    

</head>

<body>
<!--
//-----------------------------------------------------------------------------
// 사용자 인터페이스 및 시각화용 View 템플릿
//-----------------------------------------------------------------------------
-->
<div class="admin">
		
	<?
        include "inc_left_login.php";
	?>
	
    <script>
        $('#mnu01').addClass("navi_itm_selected");
    </script>

	<div class="section">

        <!--------------------------------------------------------------------------->
        <div class="title"> <b> (단계 1) 무결성 검증 정보 전송 (From SmartDevice To CA) </b> </div>        
        <!--------------------------------------------------------------------------->
	    <div class="container"> 사용자 확인이 완료되었습니다. </div>
		<div class="container"> 무결성 검증을 위한 (2) 무결성 검증키 를 CA(한국사물인증센터)에 전송합니다. (1) 스마트단말정보(Smart Device Information), (2) 시리얼번호(Serial Number), (3) 소스코드 무결성검증키를 입력해 주십시요. (참고) 기본 입력값은 저장된 LocalStorage에서 읽어옵니다. 단말정보, 시리얼번호는 한국사물인증센터에서 발급 받으신 정보를 사용합니다.</div>
	    <div class="container">
            <form>
                <div class="container">
                    <br/><br/>
                    <label><b>스마트단말정보</b></label>
                    <input id="smartdeviceinfo_id" type="text" placeholder="Enter SmartDeviceInfo: (e.g.) Samsung Smartphone 1" name="smartdeviceinfo" required onKeyPress="e.changed()">

                    <br/><br/>
                    <label><b>시리얼번호</b></label>
                    <input id="sn_id" type="text" placeholder="Enter Serial Number: (e.g.) AAAA0001" name="sn" required onKeyPress="e.changed()">

                    <br/><br/>
                    <label><b>소스코드 무결성검증키</b></label>
                    <input id="srcclientkey_id" type="text" placeholder="Enter Validation Key: (e.g.) 023gfsAadaBXE32553d....452xXdkjDFe" name="srcclientkey" required onKeyPress="e.changed()">

                    <br/><br/>
                    <label><b>[DBG] 무결성검증키 만들기 위한 입력 정보</b></label>
                    
                    <br/><br/>
                    <label for="clientinfo" id="clientinfo_id" name="clientinfo"><b>---</b></label>
                    
                    <br/><br/>
                    <label><b>생성한 무결성검증키</b></label>
                    
                    <br/><br/>
                    <label for="clientkey" id="clientkey_id" name="clientkey"><b>---</b></label>
                    
                    <br/><br/>
                    <button type="button" onClick="e.do_auth()"> CA서버에 무결성 검증키 전송하기 (Submit) </button>                
                    <br/><br/>
                    <label for="statuslabel1" id="statuslabel1_id" name="statuslabel1"><b> 상태 </b></label>
                    
                    <br/><br/>
                </div>
            </form>
		</div>
        
        <br/><br/><br/>
        <!--------------------------------------------------------------------------->
        <div class="title"> <b> (단계 2) IoT 단말들에게 인증키 전송 (From SmartDevice To IoT Devices)</b> </div>        
        <!--------------------------------------------------------------------------->
	    <div class="container">
            <form>
                <div class="container">
                
                    <br/><br/>
                    <label for="statuslabel2" id="statuslabel2_id" name="statuslabel2"><b> --- </b></label>
                    
                    <br/><br/>
                    <label><b>[DBG] 전달받은 난수값 (256비트, 32바이트)</b></label>
                    
                    <br/><br/>
                    <label for="randval" id="randval_id" name="randval"><b> --- </b></label>
                    
                    <br/><br/>
                    <label><b>[DBG] IoT용 인증키 만들기 위한 정보</b></label>

                    <br/><br/>
                    <label for="clientinfo4iot" id="clientinfo4iot_id" name="clientinfo4iot"><b> --- </b></label>                    

                    <br/><br/>
                    <label><b>스마트 기기에 등록된 IoT 디바이스들 목록</b></label>

                    <div class="container">
                        <table class='responstable' id="iotDeviceListTable" border="1">
                         </table>
                    </div>

                    <br/><br/>           
                    <label><b> 아래의 인증키를 관리하고 계산 IoT 디바이스들에게 전송합니다. </b></label>                    
                    
                    <br/><br/>           
                    <label for="iotkey" id="iotkey_id" name="iotkey"><b> --- </b></label>                    

   
                    
                    <br/><br/>
                    <br/><br/>
                    <br/><br/>
                    <button type="button" onClick="e.get_authiots()"> 인증된 IoT 단말 목록 확인하기 </button>                
                    <br/><br/>  
                    
                    <br/><br/>
                    <label><b>최종적으로 한국사물인증센터 인증이 완료된 IoT 장치들 목록입니다.</b></label>

                    <div class="container">
                        <table class='responstable' id="iotAuthDeviceListTable" border="1">
                         </table>
                    </div>
                    <!--
                    <br/><br/>
                    <label for="statuslabel3" id="statuslabel3_id" name="statuslabel3"><b> --- </b></label>
                    -->
                </div>
            </form>
		</div>
        
        
        
    </div>
</div>

<script>
    e.init();
</script>

</body>
</html>


