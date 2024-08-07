-- 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS dev;

-- 데이터베이스 사용
USE dev;

-- 사용자 생성 및 비밀번호 설정
CREATE USER IF NOT EXISTS 'dev'@'%' IDENTIFIED BY 'dev';

-- 권한 부여
GRANT ALL PRIVILEGES ON dev.* TO 'dev'@'%';

-- 권한 적용
FLUSH PRIVILEGES;

-- 테이블 생성
CREATE TABLE IF NOT EXISTS data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ip VARCHAR(45) NOT NULL,
    hostname VARCHAR(255) NOT NULL,
    temperature FLOAT NOT NULL,
    cpuclock FLOAT NOT NULL,
    mem_total INT NOT NULL,
    mem_available INT NOT NULL,
    json_str TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);