# Install MariaDB on Ubuntu Linux

- 참고 : https://blogger.pe.kr/885
- Test Link : http://deepcase.mynetgear.com:20080/pa/index.php


## MariaDB 설치

- Install 

```bash
sudo apt install mariadb-server 
sudo apt-get install mariadb-client
```

- Root 암호 설정

```bash
sudo mysql_secure_installation
```


- DB 접속

```bash
sudo mysql -u root -p mysql
```


## phpmyadmin 설치

- 설치

```bash
sudo apt update
sudo apt install phpmyadmin
```


- DB 접속 및 테이블 생성

```bash
sudo mysql -u root -p mysql
```


```sql
CREATE USER 'padmin'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'padmin'@'localhost' WITH GRANT OPTION;



```
- 상태 확인

```bash
dpkg --list | grep phpmyadmin
```


- 설정 바꾸기

```bash
sudo dpkg-reconfigure phpmyadmin
```
