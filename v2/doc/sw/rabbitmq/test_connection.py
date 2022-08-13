import pika

userInfo = pika.PlainCredentials('rabbitmq','password')
connection = pika.BlockingConnection(pika.ConnectionParameters(host = 'localhost', port = 15672, credentials = userInfo))
channel = connection.channel()


