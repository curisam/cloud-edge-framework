# FedML의 GPU 사용기능을 사용하기 위한 방법

## FedML팀에서는 Docker 컨테이너 환경에서 구동시키는 것을 추천합니다.



---------------------------------------------------------
(1) Pull the Docker image and prepare the docker environment

- Ref : https://doc.fedml.ai/starter/installation.html

- 원문에 오타가 있어서 이를 수정한 내용을 아래와 같이 정리합니다.

```bash
FEDML_DOCKER_IMAGE=fedml/fedml:cuda-11.4.0-devel-ubuntu20.04
docker pull $FEDML_DOCKER_IMAGE

# if you want to use GPUs in your host OS, please follow this link: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
sudo chmod 777 /var/run/docker.sock
```

---------------------------------------------------------
(2) Run Docker with interactive mode

```bash
FEDML_DOCKER_IMAGE=fedml/fedml:cuda-11.4.0-devel-ubuntu20.04
WORKSPACE=/home/chaoyanghe/sourcecode/FedML_startup/FedML

docker run -t -i -v $WORKSPACE:$WORKSPACE --shm-size=64g --ulimit nofile=65535 --ulimit memlock=-1 --privileged \
--env FEDML_NODE_INDEX=0 \
--env WORKSPACE=$WORKSPACE \
--env FEDML_NUM_NODES=1 \
--env FEDML_MAIN_NODE_INDEX=0 \
--env FEDML_RUN_ID=0 \
--env FEDML_MAIN_NODE_PRIVATE_IPV4_ADDRESS=127.0.0.1 \
--gpus all \
-u fedml --net=host \
$FEDML_DOCKER_IMAGE \
/bin/bash

```

```bash
cd python
# You need sudo permission to install your debugging package in editable mode 
(-e means link the package to the original location, basically meaning any changes to the original package would reflect directly in your environment)
sudo pip install -e ./
```

---------------------------------------------------------
(3) Run Docker with multiple commands to launch your project immediately

```bash
WORKSPACE=/home/chaoyanghe/sourcecode/FedML_startup/FedML

docker run -t -i -v $WORKSPACE:$WORKSPACE --shm-size=64g --ulimit nofile=65535 --ulimit memlock=-1 --privileged \
--env FEDML_NODE_INDEX=0 \
--env WORKSPACE=$WORKSPACE \
--env FEDML_NUM_NODES=1 \
--env FEDML_MAIN_NODE_INDEX=0 \
--env FEDML_RUN_ID=0 \
--env FEDML_MAIN_NODE_PRIVATE_IPV4_ADDRESS=127.0.0.1 \
-u fedml --net=host \
--gpus all \
$FEDML_DOCKER_IMAGE \
/bin/bash -c `cd $WORKSPACE/python/examples/simulation/mpi_torch_fedavg_mnist_lr_example; sh run_one_line_example.sh`
```


---------------------------------------------------------
(4) Run Docker with bootstrap.sh and entry.sh


```bash

$ vi bootstrap.sh
——-boostrap.sh———-

#!/bin/bash
echo "This is bootstrap script. You can use it to customize your additional installation and set some environment variables"

# here we upgrade fedml to the latest version.
pip install --upgrade fedml

```


```bash

$ vi entry.sh
——-entry.sh———-

#!/bin/bash
echo "This is entry script where you launch your main program."

cd $WORKSPACE/python/examples/simulation/mpi_torch_fedavg_mnist_lr_example
sh run_one_line_example.sh


```


