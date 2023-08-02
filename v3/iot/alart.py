#-*- coding: utf-8 -*-

#----------------------------------------------------------------------------------------------------------
# by JPark, KETI
# Last 2019.08.13
#----------------------------------------------------------------------------------------------------------

# e.g.
#
# https://api.telegram.org/bot689122441:AAFLOkYjy5PM3J1OBiq5JS5xCtFri0e9MPw/getUpdates
#

import datetime
import time, threading

# by Restful API
import requests
import json

def check():
    global MAX_TEMP
    global url_getdata
    global url_alert

    print("alert checking :")
    response = requests.get(url_getdata)
    if(response.ok):
        x = json.loads(response.content.decode('utf-8'))
        print(x['Temp'])
        if( float(x['Temp']) > MAX_TEMP ) :
            urltmp = url_alert + '[Warning !!] \n - current temperature is ' + str(x['Temp']) + ' C \n - humidity is '  + str(x['Humid']) + ' % \n - Pressure is ' + str(x['Pressure']) + ' hPa ' + '\n - critical temperature is : ' + str(MAX_TEMP) + ' \n' + ' - now : ' + time.ctime() + '\n - Chart : ' + url_chart 
            requests.get(urltmp)
        print('\n')

def monitor():
    global MAX_TEMP
    global url_getdata
    global url_alert
    global push_mins
    global push_hours 
    global push_weekdays

    w = datetime.datetime.today().weekday()
    h = time.localtime().tm_hour
    m = time.localtime().tm_min

    if(w in push_weekdays):
        if (h in push_hours): # and (m is push_min) : # 
            if (m in push_mins ) : # 
                print(url_getdata)
                response = requests.get(url_getdata)
                if(response.ok):
                    print("monitoring :")
                    print("weekday = ", w)
                    print("h = ", h)
                    print("m = ", m)

                    x = json.loads(response.content.decode('utf-8'))
                    print(x['Temp'])
                    urltmp = url_alert + '[Monitoring] \n - current temperature is ' + str(x['Temp']) + ' C \n - humidity is '  + str(x['Humid']) + ' % \n - Pressure is ' + str(x['Pressure']) + ' hPa ' + '\n - critical temperature is : ' + str(MAX_TEMP) + ' \n' + ' - now : ' + time.ctime() + '\n - Chart : ' + url_chart 
                    print('\n')
                    requests.get(urltmp)

def run():
    print(time.ctime())
    threading.Timer(60, run).start()
    check()
    monitor()

MAX_TEMP = 39
#push_weekdays = [0] # 0:Monday, 1:Tuesday, 2:Wednesday, 3:Thursday, 4:Friday, 5:Saturday, 6:Sunday
#push_hours = [9]
push_weekdays = [0,1,2,3,4,5,6] # 0:Monday, 1:Tuesday, 2:Wednesday, 3:Thursday, 4:Friday, 5:Saturday, 6:Sunday
push_hours = [9,12,18]
#push_mins = [3, 21, 20, 22, 25, 8, 9, 47, 55, 56, 57, 58, 59]
push_mins = [30]

#url_chart = 'http://keticmr.mynetgear.com:22080/iot/'
#url_getdata = 'http://keticmr.mynetgear.com:22080/iot/getdata.php?sn=AAAA0001'
url_chart = 'http://123.214.186.199:22080/iot/'
url_getdata = 'http://123.214.186.199:22080/iot/getdata.php?sn=AAAA0001'

# For JPark, Kwkim
url_alert = 'https://api.telegram.org/bot689122441:AAFLOkYjy5PM3J1OBiq5JS5xCtFri0e9MPw/sendMessage?chat_id=-372064851&text='

# For only JPark
#url_alert = 'https://api.telegram.org/bot689122441:AAFLOkYjy5PM3J1OBiq5JS5xCtFri0e9MPw/sendMessage?chat_id=150031891&text='

if __name__ == "__main__":
    run()

#----------------------------------------------------------------------------------------------------------
# End of this file
#----------------------------------------------------------------------------------------------------------

