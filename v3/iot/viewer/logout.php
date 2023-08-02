<?php
	// by JPark @ KETI
	// NOTICE, ONLY FOR TEST
	include("opendb.php");
	
	header("location: step1_login.php");
	return;

	// TODO
    if($_SERVER["REQUEST_METHOD"] == "GET") {   
		// POST
		//$myusername = mysqli_real_escape_string($db,$_POST['username']);
        //$mypassword = mysqli_real_escape_string($db,$_POST['password']); 
		
		// GET
	    $username = $_GET["username"];
	    $password = $_GET["password"];
		printf("username = %s <br/>", $username);
		printf("password = %s <br/>", $password);
		
		mysql_select_db('seciotdb') or die('Could not select database');
        $query = "SELECT * FROM users WHERE username='$username' and password='$password'";
        //$query = "SELECT * FROM users";
        $result = mysql_query($query) or die('Query failed: ' . mysql_error());
		
		echo('query = ' . $query . '<br/>');
		echo('result = ' . $result . '<br/>');
		
		$cnt = 0;
		while ($row = mysql_fetch_array($result, MYSQL_NUM)) {
            printf("%s, %s, %s <br/>", $row[0], $row[1], $row[2]);  
			$cnt++;
		}
		
		if($cnt == 1) {
			//session_register("username");
			//$_SESSION['login_user'] = $username;
			header("location: step2_verify_integrity.php");
		}else {
			$error = "Your Login Name or Password is invalid";
			header("location: step_fail.php");
			echo($error);
		}
	}

	mysql_free_result($result);
	include("colosedb.php");
?>


<!doctype html>
<html>
<head>
    <?
        include "inc_header.php";
    ?>
</head>

<body>
<div class="admin">
    <?
        include "inc_left.php";
    ?>
    <script>
        $('#mnu01').addClass("navi_itm_selected");
    </script>
    <div class="section">
        <div class="title"> <b> 로그아웃 하겠습니다. </b> </div>
    </div>
</div>

</body>
</html>
