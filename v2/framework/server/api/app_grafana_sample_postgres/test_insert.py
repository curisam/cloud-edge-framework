import time, threading
import psycopg2 # postgresql
import random 

def create_table(host, port, user, password, dbname, tablename):
    # create table
    import psycopg2
    conn = psycopg2.connect(database=dbname, user = user, password = password, host = host, port = port)

    cur = conn.cursor()
    cur.execute("CREATE TABLE "+ tablename + "(" + \
        "ts TIMESTAMPTZ NOT NULL DEFAULT NOW(), \
        data0 TEXT NOT NULL);") 
    print ("[+] table created : " + tablename)

    conn.commit()
    conn.close()


def run():
    dbname = 'test'
    user = 'keti'
    password = 'keti'
    host = 'localhost'
    port = 5432
    tablename = "sensordata"

    d = random.randint(1, 1000)
    data = str(d)

    try:
        create_table(host=host, port=port, user=user, password=password, dbname=dbname, tablename=tablename)
    except:
        pass

    conn = psycopg2.connect(database=dbname, user = user, password = password, host = host, port = port)
    cur = conn.cursor()

    cur.execute("INSERT INTO " + tablename + " (DATA0) VALUES ( '" + \
        data +"' )")

    conn.commit()
    print ("[+] insert one : ", data)
    conn.close()

    threading.Timer(5, run).start()

run()


