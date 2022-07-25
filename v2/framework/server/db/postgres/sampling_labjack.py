import time, threading
import psycopg2 # postgresql

def foo():
    data = 'data'

    cur.execute("INSERT INTO labjack (DATA) VALUES ( '" + \
        data +"' )")

    threading.Timer(10, foo).start()


conn = psycopg2.connect(database="test", user = "jpark", password = "", host = "localhost", port = "5432")
print ("Opened database successfully")
cur = conn.cursor()

foo()

conn.commit()
print ("Records created successfully")
conn.close()


