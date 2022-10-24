-----------------------------------------------------
# 기술문서 
 - 기술문서명 : 연동분석 프레임워크 구성을 위한 Coral Dev Board 에지 디바이스
 - 과제명 : 능동적 즉시 대응 및 빠른 학습이 가능한 적응형 경량 엣지 연동분석 기술개발
 - 영문과제명 : Development of Adaptive and Lightweight Edge-Collaborative Analysis Technology for Enabling Proactively Immediate Response and Rapid Learning
 - Acknowledgement : This work was supported by Institute of Information & communications Technology Planning & Evaluation (IITP) grant funded by the Korea government(MSIT) (No. 2021-0-00907, Development of Adaptive and Lightweight Edge-Collaborative Analysis Technology for Enabling Proactively Immediate Response and Rapid Learning).
 - 작성자 : 박종빈
-----------------------------------------------------


- 구글이 만든 머신러닝 특화형 미니 개발 보드입니다.
- 자세한 설치 과정은 아래 링크를 참고할 수 있습니다.
- 참고 : https://coral.ai/products/dev-board/

## 코랄 보드 주요 사양

- CPU:	NXP i.MX 8M SoC (quad Cortex-A53, Cortex-M4F)
- GPU:	Integrated GC7000 Lite Graphics
- ML accelerator:	Google Edge TPU coprocessor: 4 TOPS (int8); 2 TOPS per watt
- RAM:	1 GB LPDDR4 (option for 2 GB or 4 GB coming soon)
- Flash memory:	8 GB eMMC, MicroSD slot
- Wireless:	Wi-Fi 2x2 MIMO (802.11b/g/n/ac 2.4/5GHz) and Bluetooth 4.2
- USB:	Type-C OTG; Type-C power; Type-A 3.0 host; Micro-B serial console
- LAN:	Gigabit Ethernet port
- Audio:	3.5mm audio jack (CTIA compliant); Digital PDM microphone (x2); 2.54mm 4-pin terminal for stereo speakers
- Video:	HDMI 2.0a (full size); 39-pin FFC connector for MIPI-DSI display (4-lane); 24-pin FFC connector for MIPI-CSI2 camera (4-lane)
- GPIO:	3.3V power rail; 40 - 255 ohms programmable impedance; ~82 mA max current
- Power:	5V DC (USB Type-C)
- Dimensions:	88 mm x 60 mm x 24mm
- Availability:	Australia, Japan, New Zealand, Taiwan, European Union (except France, Czech Republic), Ghana, Hong Kong, India, Oman, Philippines, Singapore, South Korea, Thailand, United States




## 설치과정 및 사용법 링크

- Coral Dev Board 를 시작하는 방법입니다.
```bash
https://coral.ai/docs/dev-board/get-started#requirements
```

- OS 이미지(Mendel Linux) 선택하여 다운로드 받습니다.

```bash
https://mendel-linux.org/images/enterprise/eagle/
```

![images](img4doc/os_images.png)

혹은 아래와 같이 wget으로 특정 이미지를 다운로드 할 수 있습니다.
 
```bash
$ wget enterprise-eagle-flashcard-20211117215217.zip
```

- 다운로드한 OS 이미지를 플래시 메모리에 업데이트 합니다.

맥에서는 Etcher 도구 사용가능

```bash
https://coral.ai/docs/dev-board/reflash/#update-your-board-with-apt-get
```

![images](img4doc/os_flash.png)



- 전원을 연결하지 않고, 보드에 존재하는 4개의 어레이 스위치를 ON/OFF/ON/ON 으로 설정합니다. OS 설치 모드가 됩니다.

```bash
어레이 스위치가 너무 작아서 잘 보이지 않습니다.
돋보기나 현미경이 필요할 수 있고, 스위치를 바꾸기 위해 핀셋이나 세밀하고 뾰족한 드라이버가 필요할 수 있습니다.
```

- OS 이미지가 탑재된 플래시 메모리를 코랄 보드에 꼽습니다.

- "PWR"라고 표시된 USB-C 타입 커넥터에 전원 연결하고, 보드에 red LED 가 켜지는지 확인합니다.

- 5~10분이 지나면 red LED가 꺼지고 설치 완료됩니다. 

- red LED가 꺼졌을 때, 전원연결을 해제하고, microSD card를 제거합니다.

```bash
microSD card를 제거하는 부분이 좀 특이합니다.
내장된 8Gbytes flash memory에 운용체제를 설치하기 때문으로써, 설치 이후에 microSD카드는 외장 메모리로 활용할 수 있습니다.
```

- 전원 연결하지 않고, 스위치를 ON/OFF/OFF/OFF 으로 설정하여, 정상적인 부팅모드로 바꿉니다.

- "PWR"라고 표시된 USB-C 타입 커넥터에 전원 연결하고 부팅 시킵니다. "Mendel Linux"가 기동됩니다.

```bash
    . default user는 "mendel"입니다.
    . python 버전은 3.7.3 입니다 (enterprise-eagle-flashcard-20211117215217.zip 경우)
```

- 부팅 완료되면 {MDT 설치, 인터넷 연결, 소프트웨어 업데이트} 등을 위해 아래 링크 참고하여 진행합니다.

```bash
 https://coral.ai/docs/dev-board/get-started#connect-internet
```

## 네트워크 연결 및 상세 SW 설치 과정

- 아래 주소에 잘 기술되어 있지만, 자체 테스트 후에 과정을 다시 정리하면 아래와 같습니다.
```bash
 https://coral.ai/docs/dev-board/get-started#connect-internet
```

- 인터넷에 연결하기 위해 'nmtui'명령어를 실행하여 설정합니다. 콘솔 GUI 방식이라 가볍고 날렵합니다. 군더더기 없이 네트워크 설정, hostname 설정을 할 수 있습니다.

```bash
$ nmtui
```

- software update를 합니다.

```bash
$ sudo apt-get update
$ sudo apt-get upgrade
```

- software OS 버전을 최신으로 update를 합니다.

```bash
$ sudo apt-get update
$ sudo apt-get dist-upgrade
```

### host 컴퓨터에 MDT(Mendel Development Tool)를 설치

- 아래 참고문헌을 보면서 MDT(Mendel Development Tool)를 host 컴퓨터에 설치합니다.
- coral 보드에 설치하는 것이 아닙니다.

```bash
https://coral.ai/docs/dev-board/mdt/#install-mdt
```

### host 컴퓨터에 MDT(Mendel Development Tool)를 설치하는 내용 요약

- TODO : 맥 운영체제에서는 잘 안되고 있음


```bash
$ python3 -m pip install --user mendel-development-tool

$ echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bash_profile

$ source ~/.bash_profile

$ echo "alias mdt='winpty mdt'" >> ~/.bash_profile

$ source ~/.bash_profile


```

