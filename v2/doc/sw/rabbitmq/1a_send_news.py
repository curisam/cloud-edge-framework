#!/usr/bin/env python
import pika

#con = pika.BlockingConnection(pika.ConnectionParameters(host='localhost', port=15672))
con = pika.BlockingConnection(pika.ConnectionParameters(host='localhost'))
ch = con.channel()

ch.queue_declare(queue='book', durable=True)
ch.basic_publish(exchange='news',
                      routing_key='book.12345',
                      body='Book Data')
print(" [d] Sent ok ")
con.close()
