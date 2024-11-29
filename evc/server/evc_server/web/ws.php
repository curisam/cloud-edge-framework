<?php
// 저장할 파일 경로 설정 (예: weather_data.csv)
$filename = 'tmp/ws.csv';

// 전달된 GET 파라미터를 가져오기
$mac = isset($_GET['MAC']) ? $_GET['MAC'] : '';
$dateutc = isset($_GET['dateutc']) ? $_GET['dateutc'] : '';
$winddir = isset($_GET['winddir']) ? $_GET['winddir'] : '';
$windspeedmph = isset($_GET['windspeedmph']) ? $_GET['windspeedmph'] : '';
$windgustmph = isset($_GET['windgustmph']) ? $_GET['windgustmph'] : '';
$tempf = isset($_GET['tempf']) ? $_GET['tempf'] : '';
$hourlyrainin = isset($_GET['hourlyrainin']) ? $_GET['hourlyrainin'] : '';
$dailyrainin = isset($_GET['dailyrainin']) ? $_GET['dailyrainin'] : '';
$weeklyrainin = isset($_GET['weeklyrainin']) ? $_GET['weeklyrainin'] : '';
$monthlyrainin = isset($_GET['monthlyrainin']) ? $_GET['monthlyrainin'] : '';
$yearlyrainin = isset($_GET['yearlyrainin']) ? $_GET['yearlyrainin'] : '';
$totalrainin = isset($_GET['totalrainin']) ? $_GET['totalrainin'] : '';
$baromrelin = isset($_GET['baromrelin']) ? $_GET['baromrelin'] : '';
$baromabsin = isset($_GET['baromabsin']) ? $_GET['baromabsin'] : '';
$humidity = isset($_GET['humidity']) ? $_GET['humidity'] : '';
$tempinf = isset($_GET['tempinf']) ? $_GET['tempinf'] : '';
$humidityin = isset($_GET['humidityin']) ? $_GET['humidityin'] : '';
$uv = isset($_GET['uv']) ? $_GET['uv'] : '';
$solarradiation = isset($_GET['solarradiation']) ? $_GET['solarradiation'] : '';

// CSV 파일에 저장할 데이터 배열 생성
$data = [
    $mac,
    $dateutc,
    $winddir,
    $windspeedmph,
    $windgustmph,
    $tempf,
    $hourlyrainin,
    $dailyrainin,
    $weeklyrainin,
    $monthlyrainin,
    $yearlyrainin,
    $totalrainin,
    $baromrelin,
    $baromabsin,
    $humidity,
    $tempinf,
    $humidityin,
    $uv,
    $solarradiation
];

// 파일이 존재하지 않으면 헤더 추가
if (!file_exists($filename)) {
    $header = [
        'MAC', 'DateUTC', 'Wind Direction', 'Wind Speed (mph)', 'Wind Gust (mph)', 'Temperature (F)', 'Hourly Rain (in)', 
        'Daily Rain (in)', 'Weekly Rain (in)', 'Monthly Rain (in)', 'Yearly Rain (in)', 'Total Rain (in)', 'Barometer Rel (in)', 
        'Barometer Abs (in)', 'Humidity (%)', 'Indoor Temp (F)', 'Indoor Humidity (%)', 'UV Index', 'Solar Radiation (W/m2)'
    ];

    // 파일에 헤더 추가
    $file = fopen($filename, 'w');
    fputcsv($file, $header);
    fclose($file);
}

// 데이터 추가
$file = fopen($filename, 'a');  // 파일을 'append' 모드로 열기
fputcsv($file, $data);  // 데이터를 CSV로 저장
fclose($file);

// 결과 출력
echo "Data successfully saved.";
?>