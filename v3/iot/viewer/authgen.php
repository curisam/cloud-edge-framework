<?php
# authentication key generator 

function authgen($msg)
{
	return hash('sha256', $msg);
}

if($_SERVER["REQUEST_METHOD"] == "GET") {   
	// GET
	$msg= $_GET["msg"];
}
	
echo authgen($msg);
?>