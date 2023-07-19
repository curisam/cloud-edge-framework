# nginx 구축

## 서비스 상태 확인

- nginx 상태 확인

```bash
sudo service nginx status
```

- nginx Version 확인

```bash
sudo dpkg -l nginx
```


## 서비스 구성 변경

- 설정 파일 위치 찾기

```bash
sudo find / -name nginx.conf
```


- 설정 파일 편집

```bash
/etc/nginx/nginx.conf
```

- 기본 폴더 바꾸기 

```bash
vi /etc/nginx/sites-available/default
```

- nginx 재시작

```bash
sudo nginx -s reload

# reload ... 설정 파일을 다시 불러오기
# quit ... 서버 종료
# stop ... 서버 즉시 중단
# reopen ... 로그 파일을 다시 열기
```



