<?php
   //include('session.php');
?>

<!doctype html>
<html>
<head>
    <?
        include "inc_header.php";
    ?>
<script>
function SetKey(smartdeviceinfo_id, sn_id, srcclientkey_id) {
    this.init = function() {
        this.key_smartdevicinfo = localStorage.getItem("key_smartdevicinfo");
        this.key_sn = localStorage.getItem("key_sn");
        this.key_srcclientkey = localStorage.getItem("key_srcclientkey");
        
		$('#'+smartdeviceinfo_id).val(this.key_smartdevicinfo);
		$('#'+sn_id).val(this.key_sn);
		$('#'+srcclientkey_id).val(this.key_srcclientkey);
	}
    
	//this.key = localStorage.getItem("ikey");
	this.setkey = function() {
        this.key_smartdevicinfo = $('#'+smartdeviceinfo_id).val();
        this.key_sn = $('#'+sn_id).val();
        this.key_srcclientkey = $('#'+srcclientkey_id).val();
        
		localStorage.setItem("key_smartdevicinfo", this.key_smartdevicinfo);
        localStorage.setItem("key_sn", this.key_sn);
        localStorage.setItem("key_srcclientkey", this.key_srcclientkey);
    }
}

function EventHandler(smartdeviceinfo_id, sn_id, srcclientkey_id, statuslabel_id) {
    var setkey = new SetKey(smartdeviceinfo_id, sn_id, srcclientkey_id);
    
    this.init = function() {
        setkey.init();
    }
    
	this.changed = function() {
        this.textval = "<b> <font color='red'> 값이 바뀌었습니다. '저장하기'를 눌러서 LocalStorage에 기록하십시요. </font> </b>";
        $('#'+statuslabel_id).html(this.textval);
    }
    
	this.saved = function() {
        setkey.setkey()
        this.textval = "<b> <font color='blue'>LocalStorage 에 저장되었습니다. </font> </b>";
        $('#'+statuslabel_id).html(this.textval);
    }
}

var e = new EventHandler('smartdeviceinfo_id', 'sn_id', 'srcclientkey_id', 'statuslabel_id');
</script>

</head>

<body>
<div class="admin">
		
	<?
        include "inc_left_login.php";
	?>
	
    <script>
        $('#mnu01').addClass("navi_itm_selected");
    </script>

	<div class="section">
	    <div class="title"> <b> (사전단계) 스마트단말 단말 정보의 로컬영역 저장 </b> </div>
		<div class="container"> (1) 스마트단말정보(Smart Device Information), (2) 시리얼번호(Serial Number), (3) 소스코드 무결성검증키 입력해 주십시요. </div>
		<div class="container">   - 1. 단말정보, 시리얼번호는 한국사물인증센터에서 발급 </div>
        <div class="container">   - 2. 소스코드 무결성검증키는 앱형식의 배포판에서만 지원 (본 시뮬레이터에서는 지원하지 않습니다.) </div>
	    <div class="container">
	    <form action="verify_integrity.php">
			<div class="container">
				<label><b>스마트단말정보</b></label>
				<input id="smartdeviceinfo_id" type="text" placeholder="Enter SmartDeviceInfo: (e.g.) Samsung Smartphone 1" name="deviceinfo" required onKeyPress="e.changed()">

				<label><b>시리얼번호</b></label>
				<input id="sn_id" type="text" placeholder="Enter Serial Number: (e.g.) AAAA0001" name="sn" required onKeyPress="e.changed()">

				<label><b>소스코드 무결성검증키</b></label>
				<input id="srcclientkey_id" type="text" placeholder="Enter Validation Key: (e.g.) 023gfsAadaBXE32553d....452xXdkjDFe" name="srcclientkey" required onKeyPress="e.changed()">

                <br/>
				<label for="statuslabel" id="statuslabel_id" name="statuslabel"><b> 상태 </b></label>

				<button type="button" onClick="e.saved()"> 저장하기 (Save) </button>
                
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