# M1 Macbook

- by JPark @ KETI, 2022

## 개요
- 본 문서에서는 M1 Macbook에서 개발환경을 구축하고 분산연합학습을 수행하기 위한 환경 구성 방법을 정리합니다.
- 애플사의 맥북(Macbook)+맥OS(MacOS) 환경을 에지 디바이스로 가정합니다.
- M1 실리콘 칩을 장착한 경우를 가정합니다.
- macOS Monterey 가 설치된 경우를 가정합니다.


## 시험환경


### 시험환경 1
#### 하드웨어

- Model Name:	MacBook Pro
- Model Identifier:	MacBookPro17,1
- Chip:	Apple M1
- Total Number of Cores:	8 (4 performance and 4 efficiency)
- Memory:	8 GB
- System Firmware Version:	7429.61.2
- OS Loader Version:	7429.61.2


#### 운영체제

- macOS Monterey (version 12.1)

### 시험환경 2
#### 하드웨어
  모델명:	MacBook Pro
  모델 식별자:	MacBookPro18,4
  칩:	Apple M1 Max
  총 코어 개수:	10(8 성능 및 2 효율)
  메모리:	64 GB
  시스템 펌웨어 버전:	7459.141.1
  OS 로더 버전:	7459.141.1

#### 운영체제
- macOS Monterey (version 12.5)




## 이미 설치된 Python 개발환경 확인

이미 설치한 Python 개발환경의 경우에도 시간이 지나면 혼란스러울 수 있습니다.
아래와 같은 절차에 따라서 기 설치된 개발 환경을 확인할 수 있습니다.



## Python 개발환경 새롭게 설정

- 참고문헌 

```bash
    https://www.whatwant.com/entry/M1-TensorFlow-GPU
    https://github.com/mrdbourke/m1-machine-learning-test
```

- 기본 확인

```bash
    $ xcode-select --install
      xcode-select: error: command line tools are already installed, use "Software Update" to install updates

    $ xcode-select --version
      xcode-select version 2395.
```

- Miniforge3 설치 (M1 맥북에서는 통상의 Anaconda가 설치되지 않습니다.)

```bash
    $ wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh

    $ chmod +x Miniforge3-MacOSX-arm64.sh

    $ sh Miniforge3-MacOSX-arm64.sh

    $ conda info

    # (선택사항) shell 실행시 자동으로 conda base 활성화 켜기
    $ conda config --set auto_activate_base true

    # (선택사항) shell 실행시 자동으로 conda base 활성화 끄기
    $ conda config --set auto_activate_base false

    # 가상환경 목록을 확인합니다.
    $ conda env list

    # 원하는 가상환경을 활성화 합니다.
    $ conda activate {envname}

    # 가상환경에서 동작하는 파이썬 실행환경의 위치를 확인합니다.
    $ which python3

    # 가상환경을 나옵니다.
    $ conda deactivate

```




- 실제 tensorflow 가상환경을 구축하고 실험합니다.

```bash
    $ mkdir make_tensorflow_env_for_m1
    $ cd make_tensorflow_env_for_m1
    $ conda create --prefix ./env python=3.8
    $ conda activate ./env
    $ conda install -c apple tensorflow-deps
    $ python -m pip install tensorflow-macos
    $ python -m pip install tensorflow-metal
    $ python -m pip install tensorflow-datasets
    $ conda install jupyter pandas numpy matplotlib scikit-learn
    $ jupyter notebook
```


- jupyter notebook에서 테스트

```python

# Test code
import numpy as np
import pandas as pd
import sklearn
import tensorflow as tf
import matplotlib.pyplot as plt

# Check for TensorFlow GPU access
print(f"TensorFlow has access to the following devices:\n{tf.config.list_physical_devices()}")

# See TensorFlow version
print(f"TensorFlow version: {tf.__version__}")

# End of test code

```

- 수행 결과 예시

```bash
TensorFlow has access to the following devices:
[PhysicalDevice(name='/physical_device:CPU:0', device_type='CPU'), PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU')]
TensorFlow version: 2.9.2

```



### Ubuntu Linux 20.04에서 가상환경 만들고 pip 명령어로 패키지 설치 방법


sudo apt-get install python3.8-venv
sudo apt-get install python3-venv

```bash
python3 -m venv ./env
source ./env/bin/activate
pip3 install tensorflow-gpu
pip3 install jupyter pandas numpy matplotlib scikit-learn flwr
pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu116
pip3 list
ipython

```


- jupyter notebook에서 테스트

```python

# Test code
import numpy as np
import pandas as pd
import sklearn
import tensorflow as tf
import matplotlib.pyplot as plt

# Check for TensorFlow GPU access
print(f"TensorFlow has access to the following devices:\n{tf.config.list_physical_devices()}")

# See TensorFlow version
print(f"TensorFlow version: {tf.__version__}")

# End of test code

```



### Jetson TX2





### MiniForge로 설치된 환경 (Arm64)

```bash

# 아키텍처 확인
$ arch
  arm64

# 파이썬 경로 확인
$ which python3
  /opt/homebrew/Caskroom/miniforge/base/bin/python3

# conda 기본 정보 확인
$ conda info
  ...
       base environment : /opt/homebrew/Caskroom/miniforge/base  (writable)
      conda av data dir : /opt/homebrew/Caskroom/miniforge/base/etc/conda
  conda av metadata url : None
           channel URLs : https://conda.anaconda.org/conda-forge/osx-arm64
                          https://conda.anaconda.org/conda-forge/noarch
          package cache : /opt/homebrew/Caskroom/miniforge/base/pkgs
       envs directories : /opt/homebrew/Caskroom/miniforge/base/envs
               platform : osx-arm64
             user-agent : conda/4.14.0
  ...


```

### 로제타 에뮬레이션 모드 (i386)

```bash

$ arch
  i386

$ which python3 
  /opt/homebrew/bin/python3

```



## M1 맥북에서 다양한 가상환경 생성

### tensorflow 사용을 위해서 yaml 파일을 만들고, 가상환경을 만드는 예시

- 참고문헌 : 
```bash
  https://hardenkim.github.io/etc/etc-7/
  https://www.whatwant.com/entry/M1-TensorFlow-GPU
```

- 먼저 기존의 conda 로 만들어진 가상환경 목록을 확인합니다.

```bash
    $ conda env list
```

- 파일을 새로 엽니다.

```bash
    $ vi tensorflow-apple.yml
```

- 파일을 편집합니다. 버전 값이나, 상세한 패키지들은 확인 및 변경 가능합니다.


```bash
# tensorflow-apple.yml
name: tensorflow
     
dependencies:
    - python=3.9
    - pip>=19.0
    - jupyter
    - apple::tensorflow-deps==2.5.0
    - scikit-learn
    - scipy
    - pandas
    - pandas-datareader
    - matplotlib
    - pillow
    - tqdm
    - requests
    - h5py
    - pyyaml
    - flask
    - boto3
    - pip:
        - tensorflow-macos==2.5.0
        - tensorflow-metal==0.1.2
        - bayesian-optimization
        - gym
        - kaggle

```


- conda 가상환경을 만듭니다.

```bash
$ conda env create -f tensorflow-apple.yml -n tf4m1
```



- conda 가상환경 목록을 다시 확인하여 새로 잘 만들어졌는지 확인합니다.

```bash
    $ conda env list
```




### tensorflow 사용을 위해서 yaml 파일을 만들고, 가상환경을 만드는 예시




