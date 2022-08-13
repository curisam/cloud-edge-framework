#!/usr/bin/env python
import pika

#con = pika.BlockingConnection(pika.ConnectionParameters(host='localhost', port=15672))
con = pika.BlockingConnection(pika.ConnectionParameters(host='localhost'))
ch = con.channel()

ch.queue_declare(queue='book')
ch.basic_publish(exchange='news',
                      routing_key='book.12345',
                      body='book data')
print(" [d] Sent ok ")
con.close()
