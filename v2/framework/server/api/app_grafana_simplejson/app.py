#! /usr/local/bin/python
# -*- coding: utf-8 -*-
from calendar import timegm
from datetime import datetime
import _strptime  # https://bugs.python.org/issue7980
from flask import Flask, request, jsonify
from flask_restx import Resource, Api

app = Flask(__name__)
api = Api(app)

app.debug = True

def convert_to_time_ms(timestamp):
    return 1000 * timegm(datetime.strptime(timestamp, '%Y-%m-%dT%H:%M:%S.%fZ').timetuple())

@api.route('/hello')
class HelloWorld(Resource):
    def get(self):
        return {'hello': 'world'}

@api.route('/hello2', methods=['GET', 'POST'])
class HelloWorld2(Resource):
    def get(self):
        return self.post()
    def post(self):
        return {'hello': 'world'}

@api.route('/')
class HealthCheck(Resource):
    def get(self):
        return 'This datasource is healthy.'

@api.route('/search', methods=['GET', 'POST'])
class Search(Resource):
    def get(self):
        return self.post()
    def post(self):
        return jsonify(['A-series', 'B-series'])

@api.route('/query', methods=['GET', 'POST'])
class Query(Resource):
    def get(self):
        return self.post()
    def post(self):
        req = request.get_json()
        print('query = \n', req)
        data = [
            {
                "target": req['targets'][0]['target'],
                "datapoints": [
                    [861, convert_to_time_ms(req['range']['from'])],
                    [1767, convert_to_time_ms(req['range']['to'])]
                ]
            }
        ]
        return jsonify(data)


@api.route('/annotations', methods=['GET', 'POST'])
class Annotations(Resource):
    def get(self):
        return self.post()
    def post(self):
        req = request.get_json()
        print('annotations = \n', req)
        data = [
            {
                "annotation": 'This is the annotation',
                "time": (convert_to_time_ms(req['range']['from']) +
                         convert_to_time_ms(req['range']['to'])) / 2,
                "title": 'Deployment notes',
                "tags": ['tag1', 'tag2'],
                "text": 'Hm, something went wrong...'
            }
        ]
        return jsonify(data)


@api.route('/tag-keys', methods=['GET', 'POST'])
class TagKeys(Resource):
    def get(self):
        return self.post()
    def post(self):
        data = [
            {"type": "string", "text": "City"},
            {"type": "string", "text": "Country"}
        ]
        return jsonify(data)


@api.route('/tag-values', methods=['GET', 'POST'])
class TagValues(Resource):
    def get(self):
        return self.post()
    def post(self):
        try:
            req = request.get_json()
            print('tag-values = \n', req)

            if req['key'] == 'City':
                return jsonify([
                    {'text': 'Tokyo'},
                    {'text': 'São Paulo'},
                    {'text': 'Jakarta'}
                ])
            elif req['key'] == 'Country':
                return jsonify([
                    {'text': 'China'},
                    {'text': 'India'},
                    {'text': 'United States'}
                ])
        except:
            pass

if __name__ == '__main__':
    app.run('0.0.0.0', port=8080)

