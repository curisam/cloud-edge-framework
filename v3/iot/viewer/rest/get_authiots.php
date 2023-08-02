<?php
//-----------------------------------------------------------------------------
// JPark @ KETI, 2018
//-----------------------------------------------------------------------------
include "../randgen.php";

if(isset($_SERVER['HTTP_ORIGIN'])) {
    header("Access-Control-Allow-Origin: ".$_SERVER['HTTP_ORIGIN']);
    header('Access-Control-Allow-Credentials: true');
    header('Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept');
}

class CheckValid {
    protected $ikey;
    var $rtn = array();
    var $serverkey;
    
    function __construct() {
    }

    //------------------------------------------
    // Basic
    //------------------------------------------
    function check_validkey($chkkey) {
    
        if(0) {
            include("../../opendb.php");
            
            mysqli_select_db($conn, 'seciotdb') or die('Could not select database');
            $query = "SELECT smartdevice_id FROM smartdevices WHERE validation_key='" . $chkkey . "'";
            $result = mysqli_query($conn, $query) or die('Query failed: ' . mysqli_error());
          
            $cnt=0;        
            if ($result) {
                while($row = mysqli_fetch_row($result)){
                    $id_tmp = $row[0];
                    $cnt++;
                }
            }        

            //echo "$cnt = " + $cnt;
            include("../../closedb.php");
            return ( $cnt > 0 ? true:false );
        }        
        else {
            return true;
        }
    }
    
    function iotdevices($chkkey) {
        $d0 = array();
        $d1 = array();
        $sensor_name = '';
        $sensor_image = '';
        $sensor_sn = '';
        
        include("../../opendb.php");
        
        mysqli_select_db($conn, 'seciotdb') or die('Could not select database');
        $query = "SELECT smartdevice_id FROM smartdevices WHERE validation_key='" . $chkkey . "'";
        $result = mysqli_query($conn, $query) or die('Query failed: ' . mysqli_error());
        $cnt=0;
        if($result) {
            while( $row = mysqli_fetch_row($result) ){
                $id_tmp = $row[0];
                $cnt++;
            }            
        }
        
        $id_tmp = 1; // Hard coding
                      
        // For debugging
        // $d1 = array( "cnt" => $cnt);
        // array_push($d0, $d1);
        // $d1 = array( "query" => $query);
        // array_push($d0, $d1);
        // $d1 = array( "id_tmp" => $id_tmp);
        // array_push($d0, $d1);
        
        //$query = "SELECT sensor_name, mqtt_topicid, sensor_sn, sensor_dashboard_json, sensor_dashboard_json_fpath FROM sensors WHERE smartdevice_id='" . $id_tmp . "' and sensor_status='1' ";
        
        // For Demo
        //$query = "SELECT sensor_name, mqtt_topicid, sensor_sn, sensor_dashboard_json, sensor_dashboard_json_fpath FROM sensors WHERE smartdevice_id='" . $id_tmp . "' and sensor_status='0' ";
        $query = "SELECT sensor_name, mqtt_topicid, sensor_sn, sensor_dashboard_json, sensor_dashboard_json_fpath FROM sensors WHERE smartdevice_id='" . $id_tmp . "' and sensor_status='1' ";
                
        $result = mysqli_query($conn, $query) or die('Query failed: ' . mysqli_error());
        if($result) {
            while( $row = mysqli_fetch_row($result) ){
                $id_tmp = $row[0];
                $cnt++;
            }
        
            $sensor_name = $row[0];
            $mqtt_topicid = $row[1];
            $sensor_sn = $row[2];
            $sensor_dashboard_json = $row[3];
            $sensor_dashboard_json_fpath = $row[4];
            
            // TODO, 파일 대신에 json 데이터로 치환할 수 있도록 할 것
            // 혹은 데이터 소스만 바꿀 수 있는 방법 강구할 것 
            $d1 = array( "sensor_name" => $sensor_name,
                "mqtt_topicid" => $mqtt_topicid,
                "sensor_sn" => $sensor_sn,
                //"go_sensor" => "<a href='freeboard/dashboard.php?load=" . $sensor_dashboard_json_fpath . "' target='_blank'> GO </a>"
                "go_sensor" => "<a href='freeboard/d.php?load=" . $sensor_dashboard_json_fpath . "' target='_blank'> GO </a>"
                //"go_sensor" => $sensor_dashboard_json
            );
            array_push($d0, $d1);
        
        }
        include("../../closedb.php");
        

        return $d0;
    }
    
    function validation_basic() {
        $chkkey = $_SERVER["HTTP_KETI_TOKEN"];    
        if( $this->check_validkey( $chkkey ) ) {
            $rtn["is_valid"] = true;
            //$rtn["randval"] = randgen(32);
            $iotdevices = $this->iotdevices( $chkkey );
            $rtn["dbg3"] =$iotdevies;
            $rtn["iotdevices"] = json_encode($iotdevices);
            $rtn["dbg2"] = json_encode($iotdevices);
        } else{
            $rtn["is_valid"] = false;
            $rtn["randval"] = -1;
            $iotdevices = array(
                array(
                "model" => "iphone 18 a",
                "name" => "ios",
                "share" => 57.56,
                ),
                array(
                "model" => "iphone 18 b",
                "name" => "ios",
                "share" => 57.56,
                )
            );
            
            $rtn["iotdevices"] = json_encode($iotdevices);
        }
        
        $rtn["dbg1"] = $chkkey;
        
        return $rtn;
    }
    
    //------------------------------------------
    // With Time To Live
    //------------------------------------------
    function encrypt_ttl() {
        $key = $this->ikey;
        $m = round(date("i"));
        for($i=0;$i<$m;$i++) {
            //$key = hash("sha256", $key);
            $key = hash("sha1", $key);
        }
        //$subkey = hash("sha256", $key);
        $subkey = hash("sha1", $key);

        $rtn["key"] = $key;
        $rtn["skey"] = $skey;
        return $rtn;
    }
    
    function validation_ttl() {
        $chk = $this->encrypt_ttl();
        return ($chk["key"]==$_SERVER["HTTP_KETI_TOKEN"] || $chk["skey"]==$_SERVER["HTTP_KETI_TOKEN"]?true:false);
    }
}

$cv = new CheckValid();
echo json_encode($cv->validation_basic());

//-----------------------------------------------------------------------------
// End of this file
//-----------------------------------------------------------------------------
?>