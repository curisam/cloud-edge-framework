<?php
	
	if($_SERVER["REQUEST_METHOD"] == "GET") {   
		// GET
		$sn= $_GET["sn"];
	}
	
	if(1) {
		include("../opendb.php");
		mysqli_select_db($conn, 'seciotdb') or die('Could not select database');
		$query = "SELECT sensor_realtime_data FROM sensors WHERE sensor_sn='" . $sn . "'";
		$result = mysqli_query($conn, $query) or die('Query failed: ' . mysql_error());
        
		if ($result) {
            while($row = mysqli_fetch_row($result)){
                $json_str = $row[0];
            }
			
			//echo "" . $row[0] . "<br/>";
			//$cnt++;
            mysqli_free_result($result);
            
		}
		include("../closedb.php");
	}

    if($json_str) {
        echo trim($json_str, '"');
    }
	
?>