<?php
    //------------------------------------------------------------------------------------------
    // File : opendb.php
    // Last : 2023.08.01
    // By   : Jongbin Park @ KETI
    // 
	// Example in you internet browser 
    // http://evc.re.kr/cloud-edge-framework/v3/iot/setdata.php?sn=FFFF0001&json_str="{data:{Temperature:23.12,Humidity:42.13,Gyro:[11.23,22.32,345.23],Magnetic:[51.23,52.32,545.23]},user:KETI,status:online}"
    // http://evc.re.kr/cloud-edge-framework/v3/iot/setdata.php?sn=FFFF0001&json_str="{data:{Temperature:33.12,Humidity:42.13,Gyro:[11.23,22.32,345.23],Magnetic:[51.23,52.32,545.23]},user:KETI,status:online}"
    //------------------------------------------------------------------------------------------

    function get_client_ip() {
        $ipaddress = '';
        if (getenv('HTTP_CLIENT_IP'))
            $ipaddress = getenv('HTTP_CLIENT_IP');
            else if(getenv('HTTP_X_FORWARDED_FOR'))
                $ipaddress = getenv('HTTP_X_FORWARDED_FOR');
            else if(getenv('HTTP_X_FORWARDED'))
                $ipaddress = getenv('HTTP_X_FORWARDED');
            else if(getenv('HTTP_FORWARDED_FOR'))
                $ipaddress = getenv('HTTP_FORWARDED_FOR');
            else if(getenv('HTTP_FORWARDED'))
               $ipaddress = getenv('HTTP_FORWARDED');
            else if(getenv('REMOTE_ADDR'))
                $ipaddress = getenv('REMOTE_ADDR');
            else
                $ipaddress = 'UNKNOWN';
                return $ipaddress;
    }

    //------------------------------------------------------------------------------------------
    // <code/>
    //------------------------------------------------------------------------------------------

	if($_SERVER["REQUEST_METHOD"] == "GET") {   // GET
		$sn= $_GET["sn"];
		$json_str = $_GET["json_str"];

		//printf($sn);
		//printf("</br>");
		//printf($json_str);
	}
	else if($_SERVER["REQUEST_METHOD"] == "POST") { // POST
		//$myusername = mysqli_real_escape_string($conn,$_POST['username']);
		//$mypassword = mysqli_real_escape_string($conn,$_POST['password']); 
		
		// GET
		//$sn= $_GET["sn"];
		//$json_str = $_POST['json_str'];
		//$json_str = json_encode(json_decode($json_str));
	}
	

    // Main code
	{
		include("opendb.php");
		mysqli_select_db($conn, 'evc') or die('Could not select database');
		
		// Update
		$sql = "UPDATE sensors SET sensor_realtime_data='". $json_str ."' WHERE sensor_sn='". $sn ."' ";
		
		$result = mysqli_query($conn, $sql) or die('Query failed: ' . mysqli_error());
		
		// Insert
        $cip = get_client_ip();
		$sql = "INSERT INTO sensor_log (sensor_sn, sensor_data_json, client_ip) VALUES ('".$sn."', '".$json_str."', '".$cip."')";
		$result = mysqli_query($conn, $sql) or die('Query failed: ' . mysqli_error());
		include("closedb.php");
	}

	echo json_encode(json_decode($json_str));

    //------------------------------------------------------------------------------------------
    // </code>
    //------------------------------------------------------------------------------------------
?>

