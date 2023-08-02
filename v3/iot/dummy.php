<?php
    header("Content-type: text/json");
    $myObj=new \stdClass();
    $myObj->user_id = rand(0, 10);
    $myObj->male = rand(0, 5);
    $myObj->female = rand(0, 5);
    $myJSON = json_encode($myObj);
    echo $myJSON;
?>