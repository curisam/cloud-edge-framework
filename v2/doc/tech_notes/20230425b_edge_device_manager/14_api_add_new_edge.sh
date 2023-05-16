curl -X 'POST' \
  'http://deepcase.mynetgear.com:28004/api/edges/create' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "name": "ETRI-RPI01",
  "host": "deepcase.mynetgear.com",
  "port": 22,
  "description": "Test",
  "access_token": "AAAABBBB",
  "done": true
}'