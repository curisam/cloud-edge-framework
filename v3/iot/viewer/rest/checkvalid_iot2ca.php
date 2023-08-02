<?php
	// Browser Test URL ...   http://ketihhc.iptime.org/2017seciot/rest/a.php?json_data="{data:{Temperature:23.12,Humidity:42.13,Gyro:[11.23,22.32,345.23],Magnetic:[51.23,52.32,545.23]},user:KETI,status:online}"
    
	if($_SERVER["REQUEST_METHOD"] == "GET") {   
		$json_str = $_GET['json_data'];
	}
	
	if($_SERVER["REQUEST_METHOD"] == "POST") {
		//$json_data = $_POST['json_data'];
		$json_str = $HTTP_RAW_POST_DATA;
	}
    $json = json_decode($json_str);
	
    include("../opendb.php");
	if(1) {
        $d0 = array();
        $d1 = array();
        
		mysql_select_db('seciotdb') or die('Could not select database');
        $query = "SELECT smartdevice_id, smartdevice_name FROM smartdevices WHERE randnum='" . $json->{'randnum'} . "'";
        $result = mysql_query($query) or die('Query failed: ' . mysql_error());
        $cnt=0;
        while ($row = mysql_fetch_array($result, MYSQL_NUM)) {
            $id = $row[0];
            $name = $row[1];
            $cnt++;
        }
        
        if($cnt > 0) {
            # 센서 인증상태 갱신 
            $query = "SELECT sensor_name, sensor_sn FROM sensors WHERE smartdevice_id='" . $id . "'";
            $result = mysql_query($query) or die('Query failed: ' . mysql_error());
            while ($row = mysql_fetch_array($result, MYSQL_NUM)) {
                $sensor_name = $row[0];
                $sensor_sn = $row[1];
            
                $d1 = array("sensor_name" => $sensor_name, "mqtt_topicid" => $mqtt_topicid, "sensor_sn" => $sensor_sn );
                array_push($d0, $d1);
            
            /* 임시로 껏음 ==> 켜야함 
                if( strcmp($json->{'devicesn'}, $sensor_sn) == 0 ) {
                    // 센서들의 인증 상태를 초기화하도록 DB갱신 
                    $sql2 = "UPDATE sensors SET sensor_status='". true ."' WHERE smartdevice_id='". strval($id) ."' and sensor_sn='". $sensor_sn ."'" ;
                    $result2 = mysql_query($sql2) or die('Query failed: ' . mysql_error());
                }
            */
                // TODO, 보안 강화를 위해 리팩토링 필요함 
                $sql2 = "UPDATE sensors SET sensor_status='". true ."' WHERE sensor_sn='". $json->{'devicesn'} ."'" ;
                $result2 = mysql_query($sql2) or die('Query failed: ' . mysql_error());
                
            }
     
            // 필수 응답값 
            $rtn["is_success"] = True;
            $rtn["authkey"] = $json->{'authkey'};
            $rtn["randnum"] = $json->{'randnum'};
            
            // 디버깅용
            //$rtn["id"] = $id;
            //$rtn["sql2"] = $sql2;
            //$rtn["sensor_sn"] = $sensor_sn;
            //$rtn["smartdevice_id"] = $id;
            //$rtn["smartdevice_name"] = $name;      
            //$rtn["deviceinfo"] = $json->{'deviceinfo'};
            //$rtn["devicesn"] = $json->{'devicesn'};
            //$rtn["dbg"] = $d0;

        }
        else{
            $rtn["is_success"] = false;
            $rtn["authkey"] = $json->{'authkey'};
            $rtn["randnum"] = $json->{'randnum'};
            $rtn["smartdevice_id"] = '';
            $rtn["smartdevice_name"] = '';
        }
	}
    include("../closedb.php");

	echo(json_encode($rtn));
?>