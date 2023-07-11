# Install MariaDB on Ubuntu Linux

- 참고 : https://blogger.pe.kr/885


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


