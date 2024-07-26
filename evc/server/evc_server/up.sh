mkdir ~/.evc
mkdir ~/.evc/grafana
mkdir ~/.evc/mariadb
mkdir ~/.evc/redis
mkdir ~/.evc/redisearch
# sudo chown -R $(whoami):$(whoami) ~/.evc/grafana
# sudo chmod -R 755 ~/.evc/grafana

echo "UID=$(id -u)" > .env
echo "GID=$(id -g)" >> .env

# docker-compose up # OLD
# docker compose up -d # Run backgroud process
docker compose up # Run foreground process
