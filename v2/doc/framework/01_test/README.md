<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>


-----------------------------------------------------
# 기술문서 
 - 기술문서명 : 연동분석 프레임워크 자체시험서
 - 과제명 : 능동적 즉시 대응 및 빠른 학습이 가능한 적응형 경량 엣지 연동분석 기술개발
 - 영문과제명 : Development of Adaptive and Lightweight Edge-Collaborative Analysis Technology for Enabling Proactively Immediate Response and Rapid Learning
 - Acknowledgement : This work was supported by Institute of Information & communications Technology Planning & Evaluation (IITP) grant funded by the Korea government(MSIT) (No. 2021-0-00907, Development of Adaptive and Lightweight Edge-Collaborative Analysis Technology for Enabling Proactively Immediate Response and Rapid Learning). 
 - 작성자 : 박종빈, 박효찬, 금승우, 황지수
-----------------------------------------------------

# 연동분석 프레임워크 자체시험서

- 본 문서는 연동분석 프레임워크에 대한 자체시험서 입니다.
- 연동분석 프레임워크의 핵심구조는 다음과 같습니다.
- 핵심구성요소로는 제어노드, AI 모델 리포지토리, 데이터소스, 에지노드가 있습니다.
<img src="img4doc/00_system.png" width=450>
<!-- 
<img src="img4doc/00_system4vnv.png" width=450>
<img src="img4doc/hw4vnv.png" width=450>
-->


## 연동분석을 위한 자원 정의/식별/접근 기능 시험
---------------------------------------------------

- 연동분석을 위한 정의/식별/접근 가능을 확인합니다.
- Ansible 환경을 통해 제어노드는 에지노드 디바이스에서 학습된 가중치 또는 결과물을 상호 전달/공유합니다. 
- 에지 모니터링 및 자원 관리까지 수행할 수 있도록 구조를 설계했습니다.

### 사전 준비 : AI Hub 개방 데이터셋 다운로드

- AI Hub에 회원가입합니다.

```url
    https://aihub.or.kr/
```

- 가입 정보로 AI Hub에 로그인하고, "차로 위반 영상" 개방 데이터셋을 다운로드 합니다.
- 상기 데이터는 2021년 구축되었고, 본 PoC에서는 2022-07월 갱신된 버전을 사용했습니다.
- 상기 데이터의 규모는 286.69G입니다.
- 상기 데이터는 PoC의 목적에 맞게 차로 위반과 관련된 사진들과 pytorch model, docker file을 제공합니다.

<center>
<img width=600 src="img4doc/aihub_car01.png">
<img width=600 src="img4doc/aihub_car02.png">
</center>

### 그룹별 에지노드 접속성 확인 기능

- 제어노드의 접속성 확인
<center>
<img src="img4doc/01.png" width=700>
</center>

- 초경량 에지노드(라즈베리파이4) 그룹의 접속성 확인
<center>
<img src="img4doc/02.png" width=700>
</center>

- 고성능 에지노드(GPU 탑재) 그룹의 접속성 확인
<center>
<img src="img4doc/03.png" width=700>
</center>

- 고성능 및 초경량 에지노드의 운영체제 정보 확인

<center>
<img src="img4doc/04.png" width=700>
</center>

<center>
<img src="img4doc/05.png" width=700>
</center>



### 그룹별 에지노드 패키지 업데이트 및 업그레이드 수행 기능

- 초경량 에지노드의 패키지 업데이트 및 업그레이드 수행 확인
<center>
<img src="img4doc/11.png" width=700>
</center>

- 고성능 에지노드의 패키지 업데이트 및 업그레이드 수행 확인
<center>
<img src="img4doc/12.png" width=700>
</center>


### 그룹별 에지노드 시간 동기화 기능

- 초경량 에지노드의 시간동기화 수행 확인
<center>
<img src="img4doc/21a.png" width=700>
</center>

<center>
<img src="img4doc/21b.png" width=700>
</center>

- 고성능 에지노드의 시간동기화 수행 확인

<center>
<img src="img4doc/22a.png" width=700>
</center>

<center>
<img src="img4doc/22b.png" width=700>
</center>


### 그룹별 에지노드 모니터링 기능

- 고성능 및 초경량 에지노드의 CPU 온도 측정 기능 확인
<center>
<img src="img4doc/31.png" width=700>
</center>

- 고성능 및 초경량 에지노드의 CPU 정보 수집 기능 확인
<center>
<img src="img4doc/32.png" width=700>
</center>

- 고성능 및 초경량 에지노드의 Memory 정보 수집 기능 확인
<center>
<img src="img4doc/33.png" width=700>
</center>

- 초경량 에지노드의 네트워크 업링크/다운링크 속도 측정 기능 확인
<center>
<img src="img4doc/34.png" width=700>
</center>

- 고성능 에지노드의 네트워크 업링크/다운링크 속도 측정 기능 확인
<center>
<img src="img4doc/35.png" width=700>
</center>

- CUDA 지원 GPU 탑재된 에지노드의 GPU 정보 수집 (아래 이미지에서 w01은 GPU SW 환경이 구축된 경우이고, p01은 GPU 사용을 위한 SW환경이 구축되지 않은 경우임)
<center>
<img src="img4doc/36.png" width=700>
</center>



### 그룹별 에지노드 모델 다운로드 및 docker 빌드 기능

- AI Hub에서 다운로드 받은 모델을 모델 리포지토리에 탑재

<center>
<img src="img4doc/40.png" width=700>
</center>


- 에지노드에 모델 리포지토리의 aihub_model.zip을 배포

<center>
<img src="img4doc/41a.png" width=700>
</center>


<center>
<img src="img4doc/41b.png" width=700>
</center>


<center>
<img src="img4doc/41c.png" width=700>
</center>


- 에지노드에 docker 설치를 위한 파일 전송

<center>
<img src="img4doc/42.png" width=700>
</center>














---------------------------------------------------
## 연동분석을 위한 추론 모델 관리 및 배포 단위 기능 시험


### 사용할 Dataset
---------------------------------------------------

- https://www.cs.toronto.edu/~kriz/cifar.html

- Cifar10 : 32x32 컬러 이미지, 10개의 분류객체, 클래스당 6000장(5000장 학습, 1000장 시험), 총 60000장(50000장 학습셋 + 10000장 시험셋)

- Cifar100 : 32x32 컬러 이미지, 100개의 분류객체, 클래스당 600장(500장 학습, 100장 시험), 총 60000장(50000장 학습셋 + 10000장 시험셋)



### Advanced model distribution
모델 존재 여부 검증 및 상황에 맞는 스크립트 전달 및 수행

#### verify.py
```bash
python verify.py --url {} --arch {} --task {}
```
url, cpu architecture, task 등 정보를 통해 registry의 이미지 목록을 조회하고 모델 존재 여부를 확인하는 코드입니다.
* url : 레지스트리 서버의 주소
* arch : 모델을 사용하고자 하는 노드의 cpu architecture 정보. ```uname -a```를 통해 조회할 수 있습니다.
* task : 모델을 통해 수행하고자 하는 작업 ( ex. 과일을 분류하고자 함 => fruits )
  > task 명시에 대한 정의는 재점검이 필요합니다.
  
#### gui
>- 모델 조회, 배포 절차 수행 등에 있어 모두 코드 및 스크립트 단위로 수행하는 것은 번거롭습니다.<br>
>- CS 지식이 전무한 일반인( ex. 모델을 배포받아 사용하고자 하는 사용자 )의 경우 사용 자체가 불가능할 수 있습니다.<br>
>- 작업자의 입장에서도 조금 더 좋은 가독성을 가진 형태로 구축하기를 희망합니다.

정보 | 결과를 간결하게 조회할 수 있는 인터페이스를 구현하고, 배포 및 테스트 등 필요한 기능을 바로 수행할 수 있도록 인터페이스와 연결하여 하나의 어플리케이션 형태로 개발하고자 합니다.<br>

##### 어플리케이션 수행 기능
- 레지스트리 목록 조회
  - list 형태로 출력
- 모델 중복 여부 검증
  - 중복 bool 출력 및 다음 절차로 유도
- 모델 구축, 배포 절차 수행
  - build
  - push
  - pull
- 모델 테스트 수행
  - run
  - exec (pred)

##### REF. 구축 · 배포 전(全) 과정 흐름 도식
```mermaid
graph TD
a((USER)) -->|request|b((SERVER))
b --> |reg_url, arch, task|i([verify.py])
i --- |repo_list|c{VERIFICATION}
c --> |True|d([docker pull])
c --> |False|e([copy.yaml, autorun.yaml])
e --> |model.tar.gz|f((BUILDERS))
f --> |push new model image|h
h((registry)) --> |model_image|a
d --> h
```

### 모델 배포 시험

#### ```Input.py```
사용자가 CPU 구조와 모델을 통해 수행할 태스크 정보를 입력합니다.
>![](./img4doc/input.png)

#### ```ShowImage.py```
에지노드에서 도커 기반의 추론환경을 구성하고 입력된 이미지를 분류하는 태스크를 수행합니다.
>![](./img4doc/pred.png)

#### ```callui.py```
제어노드에서 모델레지스트리 (AI 모델리포지토리)에 접속하여 지원가능한 모델 정보를 확인할 수 있습니다.
>![](./img4doc/callui.png)

#### ```signal.py```
어플리케이션의 동작 결과를 RESTFul API로 정의하고 이를 통해 기능을 호출할 수 있습니다.
>![](./img4doc/signal.png)

#### ```listview.py```
레지스트리 서버의 모델을 리스트뷰 형태로 확인하고 있습니다.
>![](./img4doc/listview.png)

#### ```vrfbutton.py```
AI 모델이 존재하는지를 확인합니다.
>![](./img4doc/vrfbutton.png)




---------------------------------------------------
## 추론지연시간 개선 시험

- 에지 환경 추론에 따른 성능 개선을 확인하기 위해, 성능 확인에 영향을 주는 변인들은 가급적 통제하여 평가를 실시합니다.
- 상세하게는 다음과 같은 2가지 시험 구성 {Baseline, Advanced}에 따라 평가를 진행합니다.
- {Baseline}과 {Advanced}의 시험 구성에 따른 추론 지연시간을 각각 $t_{b}$, $t_{a}$ 와 같이 측정합니다.
- 이를 비교하여 추론 지연시간 개선율을 계산합니다.

$$  \Delta {t} = \frac{1}{n} \sum_{i=1}^{n} \frac{ t_{b} -  t_{a} }{ t_{b} } $$

- {Baseline}과 {Advanced}의 주요 차이점은 추론 모델 선택에 있습니다.
- (1) {Baseline}은 가용 모델 중, 가장 성능이 우수한 분석 모델을 선택하는 <b>{Greedy AI Model Selection}</b> 을 사용합니다.
- (2) {Advanced}는 장치의 {연산량, 연산자원, 네트워크 대역폭} 등을 고려하여 10% 이내의 정확도 열화를 Latency Budget으로 사용하여 추론 모델을 선택하는 <b>{Advanced AI Model Selection}</b> 을 사용합니다. 
- 상기 2가지 시험 구성을 분리하여 설명했으나, 세부 시험 구성요소는 변인통제를 위해 서로 공유가 가능합니다.
- 일례로, {Control Node, Inference Node, Model Repository}는 추론지연시간 측정을 위해 그 기능을 공유합니다.
- 에지 디바이스의 종류는 1개를 기본으로 하고 그 이상으로 확장될 수 있습니다.


### 시험 방법

#### 기본 인프라

- 추론(분석)으로 인해 발생하는 종단 간 지연시간의 평균 개선율을 측정하기 위해 다음과 같이 클라우드-엣지 환경을 설정합니다.

#### 평가 환경 및 조건

- 이기종의 네트워크 대역폭 및 불안정한 Backgroud Utilization 환경을 고려하며, 엣지 단독 추론 및 병행추론 등 다양한 유형의 분석 방식 채택 가능합니다.

#### 기준 알고리즘
- 주어진 태스크와 목적에 부합하는 딥러닝 모델 중 가장 우수한 정확도를 제공하는 모델을 엣지 추론을 위한 모델로 선정하는 Greedy AI Model Selection Algorithm을 기준 알고리즘으로 선정합니다. 

#### 추론 Budget
- 엣지 추론을 위해 모델 선별 시 허용 가능한 추론 지연시간을 일종의 예산(Budget)개념으로 활용합니다. 

#### 시험방법 의사코드

- 시험방법은 다음의 python 문법 형식의 의사코드로 표현할 수 있습니다.

```python

methods = ['baseline', 'advanced']
edges = [ 'RTX3080TI'] # ['RTX3080TI', 'NUC', 'MACMINI', 'RPI']
models = ['resnet18', 'resnet34', 'resnet50', 'resnet101', 'resnet152']
measured_time = []

# 가용 에지 디바이스들에 대해서 실험을 수행합니다.
for edge in edges:
    
    # 선택된 에지 디바이스의 상태정보를 얻습니다.
    device_status = getDeviceStatus(edge)

    # baseline 실험을 위한 모델을 선택합니다.
    model_baseline = greedModelSelection(models, device_status)
    
    # advanced 실험을 위한 모델을 선택합니다.
    model_advanced = advancedModelSelection(models, device_status)

    # 선택된 에지 디바이스에서 model_baseline을 수행합니다. 
    start_time = getTime()
    accuracy1 = runModel(model_baseline, edge)
    finish_time = getTime()
    dtime1 = finish_time - start_time

    # 선택된 에지 디바이스에서 model_advanced를 수행합니다. 
    start_time = getTime()
    accuracy2 = runModel(model_advanced, edge)
    finish_time = getTime()
    dtime2 = finish_time - start_time

    # 추론지연 절감율 측정
    latency_saving_rate = (dtime1 - dtime2) / dtime1
    diff_accuracy = accuracy1 - accuracy2
    
```

- diff_accuracy 가 10% 이내 인지 확인합니다.
- latency_saving_rate 가 20% 이상인지 확인합니다.


### 시험 구성 1 (Baseline)

- {Baseline}에서는 종래의 가장 성능이 우수한 모델을 선택하는 방식을 사용하는 {Greedy AI Model Selection} 방법을 사용하는 것을 특징으로 합니다.

- 주요 시험 구성요소는 다음과 같습니다.

  (1) Control Node (제어노드) : {MacbookPro14} --> <b>{Greedy AI Model Selection}</b> 적용

  (2) Model Repository (인공신경망 모델 리포지토리)

  (3) Inference Node (추론 노드) : {e.g. NUC GPU Edge Device, RTX3080Ti GPU Server, Macbook, RPI}


<img src="img4doc/01_baseline.png" width=500>

<img src="img4doc/expr01.png" width=200>

<img src="img4doc/expr02.png" width=200>




### 시험 구성 2 (Advanced)

- {Advanced}는 장치의 {연산량, 연산자원, 네트워크 대역폭} 등을 고려하여 10% 이내의 정확도 열화를 Latency Budget으로 사용하여 추론 모델을 선택하는 <b>{Advanced Model Selection}</b> 을 사용하는 것을 특징으로 합니다.

- 주요 시험 구성요소는 다음과 같습니다.

  (1) Control Node (제어노드) : {MacbookPro14} --> <b>{Advanced AI Model Selection}</b> 적용

  (2) Model Repository (인공신경망 모델 리포지토리)

  (3) Inference Node (추론 노드) : {e.g. NUC GPU Edge Device, RTX3080Ti GPU Server, Macbook, RPI}


<img src="img4doc/02_advanced.png" width=500>




### 사용 Dataset

- imagenet-mini 데이터셋 중에서 validatation 셋 (1,000개의 분류객체, 클래스당 약 3장씩, 3,923장)


```bash
  . https://www.kaggle.com/datasets/ifigotin/imagenetmini-1000
```

<img src="img4doc/ILSVRC2012_val_00003382.jpg" width=300>

<img src="img4doc/ILSVRC2012_val_00010218.jpg" width=300>



### 사용 모델

- Resnet, EfficientNet 계열의 신경망
- 참고 자료 출처 : https://pytorch.org/hub/pytorch_vision_resnet/

```csv
Model structure,	Top-1 error,	Top-5 error
resnet18,	30.24,	10.92
resnet34,	26.70,	8.58
resnet50,	23.85,	7.13
resnet101,	22.63,	6.44
resnet152,	21.69,	5.94
```


- Resnet 모델의 크기

| model | input size | param mem | feat. mem | flops | src | performance |
|-------|------------|--------------|----------------|-------|-----|-------------|
| [resnet18](reports/resnet18.md) | 224 x 224 | 45 MB | 23 MB | 2 GFLOPs | PT | 30.24 / 10.92 |
| [resnet34](reports/resnet34.md) | 224 x 224 | 83 MB | 35 MB | 4 GFLOPs | PT | 26.70 / 8.58 |
| [resnet-50](reports/resnet-50.md) | 224 x 224 | 98 MB | 103 MB | 4 GFLOPs | MCN | 24.60 / 7.70 |
| [resnet-101](reports/resnet-101.md) | 224 x 224 | 170 MB | 155 MB | 8 GFLOPs | MCN | 23.40 / 7.00 |
| [resnet-152](reports/resnet-152.md) | 224 x 224 | 230 MB | 219 MB | 11 GFLOPs | MCN | 23.00 / 6.70 |



## (진행중) 장치별 기초 실험 

- Cifar10, test set 10,000장에 대한 에지 기기별 추론 시간 및 정확도
- 현재는 서로 다른 환경에서 만든 전이학습 모델을 사용중임 --> 동일한 전이학습 모델로 추론 하도록 실험 수정할 것임



- 추론 정확도 budget

```csv
model, RTX3080ti(GPU), NUC(GPU)
resnet18, 91.04, 86.72
resnet34, 92.84, 88.19
resnet-50, 93.37, 89.38
resnet-101, 94.4, 91.73
resnet-152, 95.11, 91.3
```

<img src="experiments/resnet_infer_accuracy.png" width="600">

- 추론 지연시간 budget

<img src="experiments/resnet_infer_time.png" width="600">

<img src="experiments/time_cpu.png" width="600">

<img src="experiments/time_gpu.png" width="600">


```csv

model, RTX3080ti(GPU), RTX3080ti(CPU), NUC(GPU), NUC(CPU),
resnet18, 16.803656101226807, 169.54597854614258, 23.278241872787476, todo,
resnet34, 17.141077518463135, 280.5474326610565, 31.52906036376953, todo,
resnet-50, 19.997405767440796, 523.9516932964325, 43.629743814468384, todo,
resnet-101, 25.875438451766968, 805.4357748031616, 65.02895927429199, todo,
resnet-152, 30.793837785720825, 1121.0137231349945, 87.38637733459473, todo,
```



### CUDA device driver 설치 + Ubuntu 20.04

# RTX3080ti

Ubuntu 20.04 LTS, Pytorch

[RTX3080ti 설정 참고](https://github.com/etri-edgeai/cloud-edge-framework/blob/main/v2/doc/hw/rtx3080ti/README.md)


#### 설치 가능한 드라이버 설치

- 설치 가능한 버전 체크

```bash
    $ ubuntu-drivers devices
```

- 목록에 나온 드라이버를 확인한 후, 예를들어 아래와 같은 방식으로 설치

```bash
    $ sudo apt install nvidia-driver-520
```

- 재시작

```bash
    $ sudo reboot
```

- nvidia-smi 로 확인

```bash
    $ nvidia-smi
```

### (참고) 하드웨어 정보 수집 방법

```bash
    $ sudo apt install hwinfo
    $ hwinfo
```


### (참고) 임베디드 디바이스별 분석모델 처리 속도

- 그림 출처 : https://qengineering.eu/deep-learning-with-raspberry-pi-and-alternatives.html

![img](img4doc/device_chart.png)



### (참고) RESNET 구조

- Resnet18
<img src="img4doc/resnet18.png" width=400>

- Resnet34
<img src="img4doc/resnet34.png" width=400>


- Resnet50
<img src="img4doc/resnet50.png" width=400>


- Resnet101
<img src="img4doc/resnet101.png" width=400>

- Resnet152
<img src="img4doc/resnet152.png" width=400>


### (참고) 모델의 크기

. 참고 자료 출처 : https://github.com/albanie/convnet-burden


| model | input size | param mem | feat. mem | flops | src | performance |
|-------|------------|--------------|----------------|-------|-----|-------------|
| [alexnet](reports/alexnet.md) | 227 x 227 | 233 MB | 3 MB | 727 MFLOPs | MCN | 41.80 / 19.20 |
| [caffenet](reports/caffenet.md) | 224 x 224 | 233 MB | 3 MB | 724 MFLOPs | MCN | 42.60 / 19.70 |
| [squeezenet1-0](reports/squeezenet1-0.md) | 224 x 224 | 5 MB | 30 MB | 837 MFLOPs | PT | 41.90 / 19.58 |
| [squeezenet1-1](reports/squeezenet1-1.md) | 224 x 224 | 5 MB | 17 MB | 360 MFLOPs | PT | 41.81 / 19.38 |
| [vgg-f](reports/vgg-f.md) | 224 x 224 | 232 MB | 4 MB | 727 MFLOPs | MCN | 41.40 / 19.10 |
| [vgg-m](reports/vgg-m.md) | 224 x 224 | 393 MB | 12 MB | 2 GFLOPs | MCN | 36.90 / 15.50 |
| [vgg-s](reports/vgg-s.md) | 224 x 224 | 393 MB | 12 MB | 3 GFLOPs | MCN | 37.00 / 15.80 |
| [vgg-m-2048](reports/vgg-m-2048.md) | 224 x 224 | 353 MB | 12 MB | 2 GFLOPs | MCN | 37.10 / 15.80 |
| [vgg-m-1024](reports/vgg-m-1024.md) | 224 x 224 | 333 MB | 12 MB | 2 GFLOPs | MCN | 37.80 / 16.10 |
| [vgg-m-128](reports/vgg-m-128.md) | 224 x 224 | 315 MB | 12 MB | 2 GFLOPs | MCN | 40.80 / 18.40 |
| [vgg-vd-16-atrous](reports/vgg-vd-16-atrous.md) | 224 x 224 | 82 MB | 58 MB | 16 GFLOPs | N/A | - / -  |
| [vgg-vd-16](reports/vgg-vd-16.md) | 224 x 224 | 528 MB | 58 MB | 16 GFLOPs | MCN | 28.50 / 9.90 |
| [vgg-vd-19](reports/vgg-vd-19.md) | 224 x 224 | 548 MB | 63 MB | 20 GFLOPs | MCN | 28.70 / 9.90 |
| [googlenet](reports/googlenet.md) | 224 x 224 | 51 MB | 26 MB | 2 GFLOPs | MCN | 34.20 / 12.90 |
| [resnet18](reports/resnet18.md) | 224 x 224 | 45 MB | 23 MB | 2 GFLOPs | PT | 30.24 / 10.92 |
| [resnet34](reports/resnet34.md) | 224 x 224 | 83 MB | 35 MB | 4 GFLOPs | PT | 26.70 / 8.58 |
| [resnet-50](reports/resnet-50.md) | 224 x 224 | 98 MB | 103 MB | 4 GFLOPs | MCN | 24.60 / 7.70 |
| [resnet-101](reports/resnet-101.md) | 224 x 224 | 170 MB | 155 MB | 8 GFLOPs | MCN | 23.40 / 7.00 |
| [resnet-152](reports/resnet-152.md) | 224 x 224 | 230 MB | 219 MB | 11 GFLOPs | MCN | 23.00 / 6.70 |
| [resnext-50-32x4d](reports/resnext-50-32x4d.md) | 224 x 224 | 96 MB | 132 MB | 4 GFLOPs | L1 | 22.60 / 6.49 |
| [resnext-101-32x4d](reports/resnext-101-32x4d.md) | 224 x 224 | 169 MB | 197 MB | 8 GFLOPs | L1 | 21.55 / 5.93 |
| [resnext-101-64x4d](reports/resnext-101-64x4d.md) | 224 x 224 | 319 MB | 273 MB | 16 GFLOPs | PT | 20.81 / 5.66 |
| [inception-v3](reports/inception-v3.md) | 299 x 299 | 91 MB | 89 MB | 6 GFLOPs | PT | 22.55 / 6.44 |
| [SE-ResNet-50](reports/SE-ResNet-50.md) | 224 x 224 | 107 MB | 103 MB | 4 GFLOPs | SE | 22.37 / 6.36 |
| [SE-ResNet-101](reports/SE-ResNet-101.md) | 224 x 224 | 189 MB | 155 MB | 8 GFLOPs | SE | 21.75 / 5.72 |
| [SE-ResNet-152](reports/SE-ResNet-152.md) | 224 x 224 | 255 MB | 220 MB | 11 GFLOPs | SE | 21.34 / 5.54 |
| [SE-ResNeXt-50-32x4d](reports/SE-ResNeXt-50-32x4d.md) | 224 x 224 | 105 MB | 132 MB | 4 GFLOPs | SE | 20.97 / 5.54 |
| [SE-ResNeXt-101-32x4d](reports/SE-ResNeXt-101-32x4d.md) | 224 x 224 | 187 MB | 197 MB | 8 GFLOPs | SE | 19.81 / 4.96 |
| [SENet](reports/SENet.md) | 224 x 224 | 440 MB | 347 MB | 21 GFLOPs | SE | 18.68 / 4.47 |
| [SE-BN-Inception](reports/SE-BN-Inception.md) | 224 x 224 | 46 MB | 43 MB | 2 GFLOPs | SE | 23.62 / 7.04 |
| [densenet121](reports/densenet121.md) | 224 x 224 | 31 MB | 126 MB | 3 GFLOPs | PT | 25.35 / 7.83 |
| [densenet161](reports/densenet161.md) | 224 x 224 | 110 MB | 235 MB | 8 GFLOPs | PT | 22.35 / 6.20 |
| [densenet169](reports/densenet169.md) | 224 x 224 | 55 MB | 152 MB | 3 GFLOPs | PT | 24.00 / 7.00 |
| [densenet201](reports/densenet201.md) | 224 x 224 | 77 MB | 196 MB | 4 GFLOPs | PT | 22.80 / 6.43 |
| [mcn-mobilenet](reports/mcn-mobilenet.md) | 224 x 224 | 16 MB | 38 MB | 579 MFLOPs | AU | 29.40 / - |



### (참고) 데이터셋

- Cifar10 데이터셋

```bash
  . https://www.cs.toronto.edu/~kriz/cifar.html

  . Cifar10 : 32x32 컬러 이미지, 10개의 분류객체, 클래스당 6,000장(5000장 학습, 1000장 시험), 총 60,000장(50,000장 학습셋 + 10,000장 시험셋)

```



### 주요 참고문헌

```bibtex
@article{mathur2021device,
  title={On-device federated learning with flower},
  author={Mathur, Akhil and Beutel, Daniel J and de Gusmao, Pedro Porto Buarque and Fernandez-Marques, Javier and Topal, Taner and Qiu, Xinchi and Parcollet, Titouan and Gao, Yan and Lane, Nicholas D},
  journal={arXiv preprint arXiv:2104.03042},
  year={2021}
}

@article{liu2022unifed,
  title={UniFed: A Benchmark for Federated Learning Frameworks},
  author={Liu, Xiaoyuan and Shi, Tianneng and Xie, Chulin and Li, Qinbin and Hu, Kangping and Kim, Haoyu and Xu, Xiaojun and Li, Bo and Song, Dawn},
  journal={arXiv preprint arXiv:2207.10308},
  year={2022}
}
```

