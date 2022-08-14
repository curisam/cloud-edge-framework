#!/usr/bin/env python
import pika

connection = pika.BlockingConnection(pika.ConnectionParameters(host='localhost'))
channel = connection.channel()

channel.queue_declare(queue='edge1', durable=True)

def callback(ch, method, properties, body):
    print(" [d] Received %r" % body)

channel.basic_consume(queue='edge1', on_message_callback=callback, auto_ack=True)
print('[*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
    
