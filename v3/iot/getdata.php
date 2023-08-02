<?php
    // Last updated : Wed. 2019-08-14
    //   by JPark @ KETI

	if($_SERVER["REQUEST_METHOD"] == "GET") {   
		// GET
		$sn= $_GET["sn"];
	}
	
	if(1) {
		include("opendb.php");

        // Get sensor information 
		mysqli_select_db($conn, 'evc') or die('Could not select database');
		$query = "SELECT temperature_calibration_bias FROM sensors WHERE sensor_sn='" . $sn . "'" ;
		$result = mysqli_query($conn, $query) or die('Query failed: ' . mysqli_error($conn));
        
		if ($result) {
            while($row = mysqli_fetch_row($result)){
                $json_str_sensorinfo = $row[0];
            }
            mysqli_free_result($result);
		}

        // Get realtime sensor data
		mysqli_select_db($conn, 'evc') or die('Could not select database');
		$query = "SELECT sensor_data_json FROM sensor_log WHERE sensor_sn='" . $sn . "'" . " order by timestamp desc limit 1";
		$result = mysqli_query($conn, $query) or die('Query failed: ' . mysqli_error($conn));
        
		if ($result) {
            while($row = mysqli_fetch_row($result)){
                $json_str_sensordata = $row[0];
            }
            mysqli_free_result($result);
		}

		include("closedb.php");
	}

    if($json_str_sensorinfo) {
        $arr_temperaturebias = json_decode($json_str_sensorinfo);
    }
    if($json_str_sensordata) {
        $arr_sensordata = json_decode( trim($json_str_sensordata, '"') );
        //echo trim($json_str_sensordata, '"');
    }

    $arr_sensordata->Temp += $arr_temperaturebias;
    print_r( json_encode( $arr_sensordata) );
?>
