# influxdb


- Run

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


## Mac

### Install

```bash
    $ brew update
    $ brew install influxdb
```

### Start

```bash
    $ influxd 
```



