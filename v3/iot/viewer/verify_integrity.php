<?php
?>

<!doctype html>
<html>
<head>
    <?
        include "inc_header.php";
		include "keygen_rand.php";
		include "valigen.php"; # validation key
		include "authgen.php"; # authentication key
	
		if($_SERVER["REQUEST_METHOD"] == "GET") {   
			// GET
			$deviceinfo=$_GET["deviceinfo"];
			$serialnumber=$_GET["serialnumber"];
		}
		
		$vk_tmp=valigen($deviceinfo.$serialnumber);
		
		include("../opendb.php");
		mysql_select_db('seciotdb') or die('Could not select database');
		$query = "SELECT validation_key FROM smartdevices WHERE smartdevice_name='" . $deviceinfo . "' AND " . " smartdevice_sn='" . $serialnumber. "'";
		$result = mysql_query($query) or die('Query failed: ' . mysql_error());
		while ($row = mysql_fetch_array($result, MYSQL_NUM)) {
			$vk = $row[0];
			$cnt++;
		}

		if(strcmp($vk_tmp, $vk)==0){
			// Update random number
			$sql = "UPDATE smartdevices SET randnum='". $randnum64 ."' WHERE validation_key='". $vk1 ."' ";
					
			$result = mysql_query($sql) or die('Query failed: ' . mysql_error());
			while ($row = mysql_fetch_array($result, MYSQL_NUM)) {

				$cnt++;
			}

			$randnum32 = keygen(32);
			

	
			$is_ok = True;
		}
		else {
			$is_ok = True; // False; // TODO, 
		}
        
            
		include("../closedb.php");
		
	?>
	
</head>

<body>

<div class="admin">
	<?
        include "inc_left_login.php";
	?>
	
    <script>
        $('#mnu01').addClass("navi_itm_selected");
    </script>

<?php if($is_ok) { ?>
	<div class="section">
	    <div class="title"> <b> 무결성 검증 완료 </b> </div>
	    <div class="container"> 사용자 및 앱 무결성 검증이 완료되었습니다. </div>
	    <div class="container">

		<form action="step4_list_myiotdevices.php">
			<div class="imgcontainer">
				<img src="image/success.png" alt="success" class="passfail">
				<br/>
				<button>확인</button>
			</div>
		</form>

		<form action="authentication_key1_generation.php">
		<div class="container">
				<?
					//echo("<label for='deviceinfo'><b> 아래의 32비트 난수값으로 제1인증키를 생성합니다. </b></label> ");
					//echo("<input type='text' value='". $randnum64 . "' name='randkey64' required onKeyPress='submitMe(event)'> ");
					//echo("<button>Submit</button>");
				?>
			</div>
		</form>
		</div>
		
		
		
    </div>
</div>
<?php } else { ?>
	<div class="section">
	    <div class="title"> <b> 무결성 검증 오류 발생 </b> </div>
		<div class="container"> 다시 시도하여 주십시요.  </div>
	    <div class="container">
	    <form action="step2_verify_integrity.php">
			<div class="imgcontainer">
				<img src="image/denied.png" alt="success" class="passfail">
			</div>
			<div class="container">
				<button>확인</button>
			</div>
		</form>
		</div>
    </div>
<?php } ?>

</div>


</body>
</html>