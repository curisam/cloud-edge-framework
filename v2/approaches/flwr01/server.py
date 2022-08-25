# original code : https://flower.dev/

import flwr as fl

# Start Flower server
fl.server.start_server(
  server_address="[::]:8080",
  config=fl.server.ServerConfig(num_rounds=3),
)
