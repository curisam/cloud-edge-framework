#------------------------------------------------------------------------------
# Sample api for grafana node_graph plugin
# JPark @ KETI, since 2022-07-21
#------------------------------------------------------------------------------

from flask import Flask, Response, jsonify

app = Flask(__name__)

@app.route("/")
def root():
    return "API Server (KETI, 2022)", 200

@app.route("/sample/api/graph/fields", methods=["GET"])
def sample_api_graph_fields():
    s='{ "edges_fields": [ { "field_name": "id", "type": "string" }, { "field_name": "source", "type": "string" }, { "field_name": "target", "type": "string" }, { "field_name": "mainStat", "type": "number" } ], "nodes_fields": [ { "field_name": "id", "type": "string" }, { "field_name": "title", "type": "string" }, { "field_name": "mainStat", "type": "string" }, { "field_name": "secondaryStat", "type": "number" }, { "color": "red", "field_name": "arc__failed", "type": "number" }, { "color": "green", "field_name": "arc__passed", "type": "number" }, { "displayName": "Role", "field_name": "detail__role", "type": "string" } ] }' 
    d = eval(s)
    return jsonify(d) 

@app.route("/sample/api/graph/data", methods=["GET"])
def sample_api_graph_data():
    d = {}
    d['edges'] = [ {"id":"2", "mainStat": "53/s", "secondaryStat": "100", "source":"1", "target":"2"} ]
    d['nodes'] = [ {"arc__failed":0.7, "arc__passed": 0.3, "detail__zone":"load", "id":"1", "subTitle of 1": "I am subtitle of 1", "title": "I am title of 1"}, {"arc__failed":0.5, "arc__passed": 0.5, "detail__zone":"transform", "id":"2", "subTitle": "I am subtitle of 2", "title": "I am title of 2"} ]
    #return Response(d, mimetype='application/json')
    return jsonify(d) 

@app.route("/sample/api/health", methods=["GET"])
def sample_api_health():
    return "", 200


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3001)

#------------------------------------------------------------------------------
# End of this file
#------------------------------------------------------------------------------

