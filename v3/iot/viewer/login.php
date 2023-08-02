<?php
	// by JPark @ KETI
	// NOTICE, ONLY FOR TEST
	include("../opendb.php");
	
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
			header("location: login_fail.php");
			echo($error);
		}
	}

	mysql_free_result($result);
	include("../colosedb.php");
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
        <div class="title"> <b> 로그인 액션 </b> </div>
    </div>
</div>

</body>
</html>
