# sqlite db 테이블 구조와 데이터 확인 방법

## 1. sqlite3 명령어로 todo.db 파일에 접근합니다.

```bash
sqlite3 todo.db
```

## 2. .table 명령어를 사용하여 테이블 목록을 확인합니다.

```bash
sqlite> .table
```

## 3. SELECT 명령어를 사용하여 테이블 데이터를 확인합니다.

```bash
sqlite> SELECT * FROM table_name;
```

## 4. .schema 명령어를 사용하여 테이블 스키마를 확인합니다.

```bash
sqlite> .schema table_name
```

## 5. sqlite3 명령어에서 .exit 명령어를 사용하여 sqlite3 접근을 종료합니다.

```bash
sqlite> .exit
```