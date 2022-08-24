# RTX3080ti

Ubuntu 20.04 LTS, Pytorch


- 참고 

```bash
https://rdmkyg.blogspot.com/2021/12/ubuntu-2004-nvidia-gpu-cnn-2021-12-3.html
```

## CUDA + Pytorch 동작 환경 구축


### (1) 기 설치된 nvidia cuda toolkit 관련 패키지 제거

```bash
    $ sudo apt-get remove --purge '^nvidia-.*' 
    $ sudo apt-get autoremove --purge 'cuda*'
```

### (2) nvidia cuda toolkit 재설치  

- 설치

```bash
    $ sudo apt install nvidia-cuda-toolkit
```

- 설치된 cuda 버전 확인 

```bash
    $ nvcc -V
```

### (3) CUDNN 설치

- 홈페이지에 접속하고, 기 가입된 정보로 로그인 해야 다운로드 가능함
- https://developer.nvidia.com/rdp/cudnn-archive

- 예를들어, 아래와 같은 cudnn을 다운로드 받았다면, 
- 압축을 풀고

```bash
    $ tar -xvzf cudnn-10.1-linux-x64-v7.6.5.32.tgz
```

- 복사하고

```bash
    $ sudo cp cuda/include/cudnn.h /usr/lib/cuda/include/
    $ sudo cp cuda/lib64/libcudnn* /usr/lib/cuda/lib64/
```

- 권한을 설정함

```bash
    $ sudo chmod a+r /usr/lib/cuda/include/cudnn.h 
    $ sudo chmod a+r /usr/lib/cuda/lib64/libcudnn*
```

- 환경변수에 경로 등록함

```bash
    $ vi ~/.bashrc

#CUDA ENV
export LD_LIBRARY_PATH=/usr/lib/cuda/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/lib/cuda/include:$LD_LIBRARY_PATH

```

- 쉘에 환경변수 적용

```bash
    $ source ~/.bashrc
```

### (4) 설치 가능한 드라이버 설치

- 설치 가능한 버전 체크

```bash
    $ ubuntu-drivers devices
```

- 목록에 나온 드라이버를 확인한 후, 예를들어 아래와 같은 방식으로 설치

```bash
    $ sudo apt install nvidia-driver-470
```

- 재시작

```bash
    $ sudo reboot
```

- nvidia-smi 로 확인

```bash
    $ nvidia-smi
```

## Pytorch 설치

- 아래 주소를 참고

```bash
https://pytorch.org
```



