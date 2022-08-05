

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

## 설치 방법 

- Nvidia Jetson 홈페이지 방문


### 설치후 버전 확인 

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

### Install "sshd"

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



