

# Nvidia Jetson TX2


## 하드웨어 사양

- 에지 디바이스 명 : Nvidia Jetson TX2, 8GBytes

```bash
jpark@ubuntu:~$ uname -a
Linux ubuntu 4.9.253-tegra #1 SMP PREEMPT Sun Apr 17 02:37:44 PDT 2022 aarch64 aarch64 aarch64 GNU/Linux

jpark@ubuntu:~$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description: Ubuntu 18.04.6 LTS
Release: 18.04
Codename: bionic

jpark@ubuntu:~$ cat /proc/meminfo 
MemTotal:        8038788 kB
MemFree:         4851052 kB
MemAvailable:    5642288 kB
Buffers:           38972 kB
Cached:           879052 kB
SwapCached:            0 kB
Active:          1251132 kB
Inactive:         673356 kB
Active(anon):    1008140 kB
Inactive(anon):   107000 kB
Active(file):     242992 kB
Inactive(file):   566356 kB
Unevictable:          48 kB
Mlocked:              48 kB
SwapTotal:       4019376 kB
SwapFree:        4019376 kB
Dirty:                32 kB
Writeback:             0 kB
AnonPages:        976304 kB
Mapped:           425608 kB
Shmem:            108680 kB
Slab:             155880 kB
SReclaimable:      68672 kB
SUnreclaim:        87208 kB
KernelStack:       11520 kB
PageTables:        17796 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     8038768 kB
Committed_AS:    6074748 kB
VmallocTotal:   263061440 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
AnonHugePages:    172032 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
NvMapMemFree:      94784 kB
NvMapMemUsed:     805068 kB
CmaTotal:         753664 kB
CmaFree:          719864 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB

jpark@ubuntu:~$ cat /proc/cpuinfo
processor : 0
model name : ARMv8 Processor rev 3 (v8l)
BogoMIPS : 62.50
Features : fp asimd evtstrm aes pmull sha1 sha2 crc32
CPU implementer : 0x41
CPU architecture: 8
CPU variant : 0x1
CPU part : 0xd07
CPU revision : 3

processor : 3
model name : ARMv8 Processor rev 3 (v8l)
BogoMIPS : 62.50
Features : fp asimd evtstrm aes pmull sha1 sha2 crc32
CPU implementer : 0x41
CPU architecture: 8
CPU variant : 0x1
CPU part : 0xd07
CPU revision : 3

processor : 4
model name : ARMv8 Processor rev 3 (v8l)
BogoMIPS : 62.50
Features : fp asimd evtstrm aes pmull sha1 sha2 crc32
CPU implementer : 0x41
CPU architecture: 8
CPU variant : 0x1
CPU part : 0xd07
CPU revision : 3

processor : 5
model name : ARMv8 Processor rev 3 (v8l)
BogoMIPS : 62.50
Features : fp asimd evtstrm aes pmull sha1 sha2 crc32
CPU implementer : 0x41
CPU architecture: 8
CPU variant : 0x1
CPU part : 0xd07
CPU revision : 3

```

## Install JetPack on your Jetson device.

- Nvidia Jetson 홈페이지 방문
- https://developer.nvidia.com/embedded/jetpack

### 설치후에 jetpack 버전 확인 방법

- 버전 확인

```bash
$ sudo apt-cache show nvidia-jetpack


Package: nvidia-jetpack
Version: 4.6.2-b5
Architecture: arm64
Maintainer: NVIDIA Corporation
Installed-Size: 194
Depends: nvidia-cuda (= 4.6.2-b5), nvidia-opencv (= 4.6.2-b5), nvidia-cudnn8 (= 4.6.2-b5), nvidia-tensorrt (= 4.6.2-b5), nvidia-visionworks (= 4.6.2-b5), nvidia-container (= 4.6.2-b5), nvidia-vpi (= 4.6.2-b5), nvidia-l4t-jetson-multimedia-api (>> 32.7-0), nvidia-l4t-jetson-multimedia-api (<< 32.8-0)
Homepage: http://developer.nvidia.com/jetson
Priority: standard
Section: metapackages
Filename: pool/main/n/nvidia-jetpack/nvidia-jetpack_4.6.2-b5_arm64.deb
Size: 29356
SHA256: 6e3cf64d4fb46224c213ebd0cadae22d14c25dbe6dc3628d6440beeab33fed8d
SHA1: 35cd143b91a323dae4ecfd2d2f907a0efd2fb9aa
MD5sum: f0c9e65929dd73796967822c2fd99f3d
Description: NVIDIA Jetpack Meta Package
Description-md5: ad1462289bdbc54909ae109d1d32c0a8
```

### 기타 정보 확인

- 기타 
```bash
$ cat /etc/nv_tegra_release
```

```bash
    $ lsb_release -a
```

```bash
No LSB modules are available.
Distributor ID:	Raspbian
Description:	Raspbian GNU/Linux 11 (bullseye)
Release:	11
Codename:	bullseye
```



## pip 개발 환경 설치
https://docs.nvidia.com/deeplearning/frameworks/install-tf-jetson-platform/index.html

```bash
$ sudo apt-get update
$ sudo apt-get install libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran
```

```bash
$ sudo apt-get install python3-pip
$ sudo pip3 install -U pip testresources setuptools==49.6.0 
```

```bash
$ sudo pip3 install -U --no-deps numpy==1.19.4 future==0.18.2 mock==3.0.5 keras_preprocessing==1.1.2 keras_applications==1.0.8 gast==0.4.0 protobuf pybind11 cython pkgconfig packaging
$ sudo env H5PY_SETUP_REQUIRES=0 pip3 install -U h5py==3.1.0
```

## tensorflow 개발 환경 설치
https://docs.nvidia.com/deeplearning/frameworks/install-tf-jetson-platform/index.html

- [중요] 설치된 jetpack 버전을 확인해야 함
- "$ sudo apt-cache show nvidia-jetpack"
- 명령어로 확인 결과 4.6.xx 버전이므로, 아래 명령어에서 v46을 기입함

```bash
$ sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v46 tensorflow
```

## pytorch 개발 환경 설치

- 참고 주소 : https://ropiens.tistory.com/68


```bash
sudo apt-get update
sudo apt-get upgrade

############################## python 3 #######################################
# if you not install pip (python3)
sudo apt-get install python3-pip
pip install --upgrade pip3

# install torch v1.7 (for python 3)
wget https://nvidia.box.com/shared/static/wa34qwrwtk9njtyarwt5nvo6imenfy26.whl -O torch-1.7.0-cp36-cp36m-linux_aarch64.whl
sudo apt-get install python3-pip libopenblas-base libopenmpi-dev 
pip3 install Cython
pip3 install numpy torch-1.7.0-cp36-cp36m-linux_aarch64.whl

# install torchvision v0.8.1 (for python3)
sudo apt-get install libjpeg-dev zlib1g-dev libpython3-dev libavcodec-dev libavformat-dev libswscale-dev
git clone --branch v0.8.1 https://github.com/pytorch/vision torchvision
cd torchvision
export BUILD_VERSION=0.8.1 
sudo python3 setup.py install

```



- test code
```python
# Verify CUDA (from python interactive terminal)
import torch
print(torch.cuda.is_available())
a = torch.cuda.FloatTensor(2).zero_()
print(a)
b = torch.randn(2).cuda()
print(b)
c = a + b
print(c)
```






### YoloV5-torch 설치

- 참고자료 : https://ropiens.tistory.com/68
- yolov5에 필요한 라이브러리들을 설치합니다.
- [중요 사항] yolov5는 opencv-python 4.1 이상의 버전이 필수적입니다.

- 기본 설치

```bash
# pip3 upgrade to ver 20.2.4
sudo pip3 install pip --upgrade

# base
pip3 install matplotlib
pip3 install Pillow
pip3 install PyYAML
pip3 install scipy

# if scipy version < 1.0
# pip3 install scipy --upgrade

pip3 install tensorboard
pip3 install tqdm
pip3 install opencv-python
pip3 install seaborn
```


- YoloV5 clone

```bash
# git clone yolov5
$ sudo git clone https://github.com/ultralytics/yolov5.git
```

- 다운로드 받은 폴더로 이동
```bash
$ cd yolov5
```

- 사전에 학습된 욜로 모델 다운로드 (pytorch용) : https://github.com/ultralytics/yolov5/releases

```bash
$ wget https://github.com/ultralytics/yolov5/releases/download/v6.1/yolov5l.pt
```

- 검출 예제 실행

```
$ python3 detect.py --source data/images --weights yolov5s.pt --conf 0.25
```






## Install "sshd"

터미널에서 아래의 명령어를 실행합니다.

```bash
$ sudo systemctl enable ssh
$ sudo systemctl start ssh
```

### IP 정보 확인

- IP 정보를 확인하여 내부/외부에서 접속합니다.

```bash
$ ifconfig | grep 192
```


### SSH 연결 시 멈춤현상

- 원인에 대한 설명은 아래와 같습니다.

```bash
https://discourse.osmc.tv/t/solved-ssh-connection-sometimes-hangs/76504/5


IPQoS cs0 cs0

Edit: explaination of the problem:
OpenSSH sets the TOS (type Of Service) field in the IP datagram as “lowdelay” for interactive sessions and “throughput” for non-interactive sessions. My router doesn’t handle properly those settings, so I changed them in Cs0, Cs0 (aka 0x00, 0x00) <==> (best effort, best effort) and solved the instability/freeze SSH issues.
```

- 처리 방법 

파일 열기 

```bash
    $ vi /etc/ssh/sshd_config
```

아래 내용 추가

```bash
      IPQoS cs0 cs0
```

서비스 재시작

```bash
$ sudo systemctl restart ssh
```


### 슈퍼유저 권한 사용자 추가

- 사용자 생성

```bash
$ sudo adduser username
```

- 슈퍼유저 권한 부여

```bash
$ sudo usermod -aG sudo username
```






## Install Packages

```bash
# pip3 upgrade to ver 20.2.4
sudo pip3 install pip --upgrade

# base
pip3 install matplotlib
pip3 install Pillow
pip3 install PyYAML
pip3 install scipy

# if scipy version < 1.0
# pip3 install scipy --upgrade

pip3 install tensorboard
pip3 install tqdm
pip3 install opencv-python

```


### Jetson TX2에 SD card를 끼우고, Root 시스템을 복사하는 법

- 기본 탑재된 emmc 메모리 용량이 적음
- 대용량 SD카드를 끼우고 확장 가능
- 아래 주소에 설명이 상세히 잘 되어 있음
https://www.forecr.io/blogs/bsp-development/change-root-file-system-to-sd-card-directly

