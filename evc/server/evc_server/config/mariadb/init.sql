-- 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS beacon_ip;

-- 데이터베이스 사용
USE beacon_ip;

-- 테이블 생성
CREATE TABLE IF NOT EXISTS data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ip VARCHAR(45) NOT NULL,
    hostname VARCHAR(255) NOT NULL,
    temperature FLOAT NOT NULL,
    cpuclock FLOAT NOT NULL,
    mem INT NOT NULL,
    json_str TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
