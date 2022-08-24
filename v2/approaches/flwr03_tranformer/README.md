# Federated HuggingFace Transformers using Flower and PyTorch

- https://github.com/adap/flower/tree/main/examples/quickstart_huggingface

git clone --depth=1 https://github.com/adap/flower.git && mv flower/examples/quickstart_huggingface . && rm -rf flower && cd quickstart_huggingfaceo

-- pyproject.toml
-- client.py
-- server.py
-- README.md

poetry install
poetry shell


python3 -c "import flwr"


python3 server.py

python3 client.py

python3 client.py


