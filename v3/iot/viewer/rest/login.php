<?php

if(isset($_SERVER['HTTP_ORIGIN'])) {
    header("Access-Control-Allow-Origin: ".$_SERVER['HTTP_ORIGIN']);
    header('Access-Control-Allow-Credentials: true');
    header('Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept');
}

if($_SERVER["REQUEST_METHOD"] == "GET") {   
		$json_str = $_GET['json_data'];
	}
	
	if($_SERVER["REQUEST_METHOD"] == "POST") {
		//$json_data = $_POST['json_data'];
		$json_str = $HTTP_RAW_POST_DATA;
	}
    $json = json_decode($json_str);
	
    include("../opendb.php");
	    $username = $_GET["username"];
	    $password = $_GET["password"];
		mysql_select_db('seciotdb') or die('Could not select database');
        $query = "SELECT * FROM users WHERE username='$username' and password='$password'";
        $result = mysql_query($query) or die('Query failed: ' . mysql_error());

		$cnt = 0;
		while ($row = mysql_fetch_array($result, MYSQL_NUM)) {
			$uname = $row[1];
			$uidx = $row[0];
			$cnt++;
		}
		
		if($cnt == 1) {
			$dat = array();
			$dat["username"] = $uname;
			$dat["idx"] = $uidx;
			$dat["err"] = 0;

		}else {
			$dat = array();
			$dat["err"] = 100;
			$dat["err_msg"] = "Your Login Name or Password is invalid";
		}
echo json_encode($dat);

?>