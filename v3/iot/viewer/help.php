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
        include "inc_left_monitor.php";
    ?>
    <script>
        $('#mnu01').addClass("navi_itm_selected");
    </script>
    <div class="section">
        <div class="title"> <b> 개요 </b> </div>
		<div class="container">
			<iframe width=100% height=1600 src='help/index.php?src=md/readme.md'></iframe>
		</div>
    </div>
</div>

</body>
</html>
