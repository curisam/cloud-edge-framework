# postgres DB

- 참고 : https://www.tutorialspoint.com/postgresql/postgresql_python.htm


## Install

```bash
$ brew install postgresql
```

```bash
$ pip install psycopg2 
```



# open
```python



import psycopg2
conn = psycopg2.connect(database="test", user = "jpark", password = "", host = "localhost", port = "5432")
print ("Opened database successfully")

# create table
import psycopg2
conn = psycopg2.connect(database="test", user = "jpark", password = "", host = "localhost", port = "5432")
print ("Opened database successfully")

cur = conn.cursor()
try:
    cur.execute('''CREATE TABLE COMPANY
        (ID INT PRIMARY KEY     NOT NULL,
        NAME           TEXT    NOT NULL,
        AGE            INT     NOT NULL,
        ADDRESS        CHAR(50),
        SALARY         REAL);''')
    print ("Table created successfully")
except:
    print ("Table exist")

conn.commit()
conn.close()



# insert 
import psycopg2
conn = psycopg2.connect(database="test", user = "jpark", password = "", host = "localhost", port = "5432")
print ("Opened database successfully")

cur = conn.cursor()

cur.execute("INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) \
      VALUES (1, 'Paul', 32, 'California', 20000.00 )");

cur.execute("INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) \
      VALUES (2, 'Allen', 25, 'Texas', 15000.00 )");

cur.execute("INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) \
      VALUES (3, 'Teddy', 23, 'Norway', 20000.00 )");

cur.execute("INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) \
      VALUES (4, 'Mark', 25, 'Rich-Mond ', 65000.00 )");

conn.commit()
print ("Records created successfully")
conn.close()



# select

#!/usr/bin/python

import psycopg2

conn = psycopg2.connect(database = "test", user = "todo", password = "todo", host = "127.0.0.1", port = "5432")
print ("Opened database successfully")

cur = conn.cursor()

cur.execute("SELECT id, name, address, salary  from COMPANY")
rows = cur.fetchall()
for row in rows:
   print ("ID = ", row[0])
   print ("NAME = ", row[1])
   print ("ADDRESS = ", row[2])
   print ("SALARY = ", row[3], "\n")

print ("Operation done successfully")
conn.close()



# update
#!/usr/bin/python

import psycopg2
conn = psycopg2.connect(database = "test", user = "jpark", password = "", host = "localhost", port = "5432")
print ("Opened database successfully")

cur = conn.cursor()

cur.execute("UPDATE COMPANY set SALARY = 25000.00 where ID = 1")
conn.commit()
print ("Total number of rows updated :", cur.rowcount)

cur.execute("SELECT id, name, address, salary  from COMPANY")
rows = cur.fetchall()
for row in rows:
   print ("ID = ", row[0])
   print ("NAME = ", row[1])
   print ("ADDRESS = ", row[2])
   print ("SALARY = ", row[3], "\n")

print ("Operation done successfully")
conn.close()


# Delete


import psycopg2
conn = psycopg2.connect(database = "test", user = "jpark", password = "", host = "localhost", port = "5432")
print ("Opened database successfully")

cur = conn.cursor()

cur.execute("DELETE from COMPANY where ID=2;")
conn.commit()
print ("Total number of rows deleted :", cur.rowcount)

cur.execute("SELECT id, name, address, salary  from COMPANY")
rows = cur.fetchall()
for row in rows:
   print ("ID = ", row[0])
   print ("NAME = ", row[1])
   print ("ADDRESS = ", row[2])
   print ("SALARY = ", row[3], "\n")

print ("Operation done successfully")
conn.close()


```




### Labjack 

```python


# create table
import psycopg2
conn = psycopg2.connect(database="test", user = "jpark", password = "", host = "localhost", port = "5432")
print ("Opened database successfully")

cur = conn.cursor()
cur.execute('''CREATE TABLE labjack(
    ts TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    data TEXT NOT NULL);''')
print ("Table created successfully")

conn.commit()
conn.close()





import psycopg2
conn = psycopg2.connect(database="test", user = "jpark", password = "", host = "localhost", port = "5432")
print ("Opened database successfully")

cur = conn.cursor()

cur.execute("INSERT INTO labjack (DATA) \
      VALUES ('Paul')");

conn.commit()
print ("Records created successfully")
conn.close()



```