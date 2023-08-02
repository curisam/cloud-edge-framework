<?PHP
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
        include "inc_left_login.php";
    ?>
    <script>
        $('#mnu01').addClass("navi_itm_selected");
	</script>
	<div class="section">
		<div class="title"> <b> <font color="red"> [ 로그인실패 ] 로그인 단계에서 인증이 실패했습니다. </font> </b> </div>
		<div class="container"> 죄송합니다. 다시 로그인하여 주십시요. </div>
		<div class="container"> <form action="login.php">

			<div class="imgcontainer">
				<img src="image/img_avatar2.png" alt="Avatar" class="avatar">
			</div>

			<div class="container">
				<label for='username'><b>Username</b></label>
				<input type="text" placeholder="Enter Username : (e.g.) testuser" name="username" required>
			
				<label for='password'><b>Password</b></label>
				<input type="password" placeholder="Enter Password : (e.g.) testuser" name="password" required> 

				<button type="submit" name='Submit' value='Submit'>Login</button>
				<!--
				<input type="checkbox" checked="checked"> Remember me
				-->
			</div>

			<!--
			<div class="container" style="background-color:#f1f1f1">
				<button type="button" class="cancelbtn">Cancel</button> 
				<span class="psw">Forgot <a href='reset-pwd-req.php'>password?</a></span>
			</div>
			-->
		</form>	</div>
    </div>
</div>




</body>
</html>
