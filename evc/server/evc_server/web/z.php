<?php
$accessed_ip = '192.168.1.6';
$hostname = 'p01';
$temperature = 45.5;
$cpuclock = 2400.0;
$mem = 1024;
$json_str = json_encode(array("key" => "value"));

// 데이터베이스 접속 설정
$servername = "localhost";
$username = "root";
$password = "evc";
$dbname = "beacon_ip";

// MySQLi 접속
$conn = new mysqli($servername, $username, $password, $dbname);

// 접속 확인
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// 데이터 삽입 쿼리
$sql = "INSERT INTO data (ip, hostname, temperature, cpuclock, mem, json_str) VALUES ('$accessed_ip', '$hostname', '$temperature', '$cpuclock', '$mem', '$json_str')";

// 쿼리 실행
if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

// 접속 종료
$conn->close();
?>