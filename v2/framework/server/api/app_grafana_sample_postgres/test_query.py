
# select

#!/usr/bin/python

import psycopg2

def open_db(tablename):
    dbname = 'test'
    user = 'keti'
    password = 'keti'
    host = 'localhost'
    port = 5432

    conn = psycopg2.connect(database=dbname, user = user, password = password, host = host, port = port)

    return conn


tablename = "sensordata"
conn = open_db(tablename)
cur = conn.cursor()
cur.execute("SELECT ts, data0 from " + tablename)
rows = cur.fetchall()
for row in rows:
   print ("ts = ", row[0])
   print ("data = ", row[1], "\n")

conn.close()
