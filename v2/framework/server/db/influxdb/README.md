# influxdb


- Docker 기반 설치 및 실행

```bash
    $ docker run -d --name=influxdb_edgeai -it -p 8086:8086 -p 8083:8083 -e INFLUXDB_ADMIN_ENABLED=true -v influxdb:/var/lib/influxdb influxdb

    $ docker run -p 8086:8086 \
      -v influxdb:/var/lib/influxdb \
      -v influxdb2:/var/lib/influxdb2 \
      -v $PWD/influxdb.conf:/etc/influxdb/influxdb.conf \
      -e DOCKER_INFLUXDB_INIT_MODE=upgrade \
      -e DOCKER_INFLUXDB_INIT_USERNAME=jpark \
      -e DOCKER_INFLUXDB_INIT_PASSWORD=adminadmin\
      -e DOCKER_INFLUXDB_INIT_ORG=my-org \
      -e DOCKER_INFLUXDB_INIT_BUCKET=my-bucket \
      influxdb:2.0

    $ docker run -p 8086:8086 -v influxdb:/var/lib/influxdb -v influxdb2:/var/lib/influxdb2 -v $PWD/influxdb.conf:/etc/influxdb/influxdb.conf -e DOCKER_INFLUXDB_INIT_MODE=upgrade -e DOCKER_INFLUXDB_INIT_USERNAME=jpark -e DOCKER_INFLUXDB_INIT_PASSWORD=adminadmin -e DOCKER_INFLUXDB_INIT_ORG=my-org -e DOCKER_INFLUXDB_INIT_BUCKET=my-bucket influxdb:2.0

```


## Mac에서 brew로 설치 및 실행

### Install

```bash
    $ brew update
    $ brew install telegraf
    $ brew upgrade telegraf
    $ telegraf -version
      Telegraf 1.23.2
    $ cat /opt/homebrew/etc/telegraf.conf
    $ export TELEGRAF_CONFIG_PATH=/opt/homebrew/etc/telegraf.conf
    $ telegraf -test
    $ telegraf --input-filter cpu:mem --test


    $ brew install influxdb
    $ /opt/homebrew/opt/influxdb/bin/influxd version
    $ brew install influxdb-cli
```

### Start

```bash
    $ influxd 
```

admin / adminadmin

# Set up a configuration profile
influx config create -n default -u http://localhost:8086 -o test -t admin -a


influx setup --username admin --password 'adminadmin' --org ANONYM_GRP --bucket test --retention 1w --force


influx config create -n default   -u http://localhost:8086   -o example-org   -t mySuP3rS3cr3tT0keN   -a