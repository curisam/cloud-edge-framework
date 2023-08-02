

<?php
//-----------------------------------------------------------------------------
// JPark @ KETI, 2018
//-----------------------------------------------------------------------------
//include('session.php');
?>

<!doctype html>
<html>
<head>

<script>
</script>    

</head>

<body bgcolor=000000>

<center>
    <br/>
    <b> <font color=#DDEEEE> 멀티모달 환경정보 모니터링 (KETI 서버실) </font> </b>
    <?php
        include("opendb.php");
    ?>
        
    <p> 센서 데이터 </p>
    <iframe frameBorder=0 width=800 height=1000 src='freeboard/d.php?load=dashboard_serverroom.json' target='_blank'> </iframe>
    
    <?php
        include("closedb.php");
    ?>	
    
</center>    
</body>
</html>