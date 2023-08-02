<?php
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
        <div class="title"> <b> Sensor Monitoring </b> </div>
		<div class="container">
			<iframe width=100% height=1000 src='help/parser.php?src=help_service_concept.md'></iframe>
		</div>
    </div>
</div>

</body>
</html>
