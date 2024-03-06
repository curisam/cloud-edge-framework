### 이 구성 파일들은 macOS를 기준으로 작성되었습니다.

# 기본 구성
## 1. Install required packages
```shell
#If you don't have Homebrew installed, install it.
#homebrew가 설치되어있지 않다면 homebrew 설치 후, 패키지를 설치합니다.
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

#Install packages
brew install terraform awscli
```
Linux, Windows의 경우, terraform과 awscli를 직접 설치하시면 됩니다.

[https://developer.hashicorp.com/terraform/downloads?product_intent=terraform](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform)


- Windows의 경우, instance id를 통해 ssh를 접속하는 방식이 지원되지 않습니다.
- 아래의 방법은 Linux 및 macOS에서 가능하며, 아래 설정 시 `ssh -i <key file> ubuntu@<instanceid>` 로 접속할 수 있게 됩니다.
## 2-a. ~/.ssh/config setting for SSH connection using session manager
```shell
#add below texts in ~/.ssh/config!
#replace <AWS PROFILE NAME> ex) default
Host i-* mi-*
  ProxyCommand sh -c "aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p' --profile <AWS PROFILE NAME>"
```

- 아래의 방법은 macOS에서만 가능하며, ssh key를 `ssh-add -k <key file>`을 통해 ssh agent에 key 추가 했을 경우, key file을 입력할 필요 없이 `ssh ubuntu@<instanceid>` 로 접속할 수 있게 됩니다.
## 2-b-1. ~/.ssh/config setting for SSH connection using session manager with ssh agent (preferred) [Only macOS]

```shell
#add below texts in ~/.ssh/config!
#replace <AWS PROFILE NAME> ex) default
Host i-* mi-*
  ProxyCommand sh -c "aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p' --profile <AWS PROFILE NAME>"
  AddKeysToAgent yes
  UseKeyChain yes
  ForwardAgent yes
```

## 2-b-2. Add SSH Key to keychain [Only macOS]
```shell
ssh-add -K '<KEY PATH>'
```

## 3. Create EC2 Key Pair on your prefer region.
- 아래 terraform variables.tf 파일 설정 시 생성한 keypair의 이름을 사용하게 됩니다.

## 4. Set AWS CLI Profile
```shell
aws configure --profile <AWS PROFILE NAME>
AWS Access Key ID: <ACCESS KEY> # must be specified
AWS Secret Access Key: <SECRET ACCESS KEY> # must be specified
Default region name: <REGION> # must be specified
...
```
<br>

# Terraform variable 설정

## 1. Set main variables in variables.tf
#### variables.tf.samples를 복사하여 variables.tf를 생성합니다.
#### variables.tf에서는 아래와 같은 내용을 설정할 수 있습니다.
- main_suffix (string) : 생성되는 리소스 Name tag 맨 앞에 붙을 문자열을 지정합니다. 이와 관련해서는 main.tf의 module.k8s의 cluster_prefix와 module.vpc의 vpc_name을 참고합니다. 기본적으로 자신의 이름 이니셜을 사용합니다. ex) gdhong (홍길동)
- region (string) : Kubernetes Clsuter를 생성할 AWS Region을 지정합니다. 기본 값은 **"us-west-1" (캘리포니아)**입니다.
- awscli_profile (string) : AWS CLI의 profile name을 지정합니다.
- key_name (string) : Kubernetes Cluster의 EC2 Instance의 EC2 Key Pair를 지정합니다.
- master_node_number (number) : Kubernetes master node의 개수를 지정합니다. 기본 값은 **1**입니다.
- amd64_worker_node_number (number) : AMD64 아키텍쳐를 사용하는 Kubernetes worker node의 개수를 지정합니다. 기본 값은 **1**입니다.
- arm64_worker_node_number (number) : ARM64 아키텍쳐를 사용하는 Kubernetes worker node의 개수를 지정합니다. 기본 값은 **1**입니다.
- amd64_instance_type (string): Kubernetes Cluster의 AMD64 아키텍쳐를 사용하는 EC2 Instance의 Instance Type을 지정합니다.
- arm64_instance_type (string): Kubernetes Cluster의 ARM64 아키텍쳐를 사용하는 EC2 Instance의 Instance Type을 지정합니다.

# 사용 방법
## 1. terraform init
- 최초 1회 `terraform init` 명령을 통해 모듈을 불러와야 합니다.

## 2-1. terraform apply
- `terraform apply` 명령을 통해 terraform에 정의된 infra가 aws 환경에 생성됩니다.

## 2-2. terraform destroy
- `terraform destroy`으로 terraform을 통해 생성된 infra가 aws 환경에서 삭제됩니다.

# 주의 사항
1. 반드시 실습을 종료 후 `terraform destroy`를 할 필요는 없으며, instance를 stop 하면 됩니다.
2. 환경 재구성이 필요할 경우 간편하게 destroy 후 다시 apply 하면 초기상태에서 시작할 수 있습니다.