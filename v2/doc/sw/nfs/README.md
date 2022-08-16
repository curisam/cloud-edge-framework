# NFS (Network File System)

- 참고 : https://wikidocs.net/64941


## NFS 서버 서버 구축 (Ubuntu Linux 20.04 LTS)

- 관련 프로그램 설치

```bash
    $ sudo apt update
    $ sudo apt install nfs-kernel-server
    $ sudo apt install rpcbind
```

- port 확인
```bash
    $ rpcinfo -p
```

- 파일 내보내기 디렉토리 생성 (모든 클라이언트 머신이 공유 디렉토리에 액세스하기, 원하는대로 파일 권한을 조정 가능)

```bash
    $ sudo mkdir -p /mnt/nfs_share
    $ sudo chown -R nobody:nogroup /mnt/nfs_share/
    $ sudo chmod 777 /mnt/nfs_share/
```

- 네트워크 내부의 모든 컴퓨터에 NFS 접근 권한 부여

```bash
    $ sudo vim /etc/exports

       /mnt/nfs_share  192.168.0.0/24(rw,sync,no_subtree_check)
```

- 네트워크 내부의 단일 클라이언트 별로 접근 권한 설정 가능


```bash
    $ sudo vim /etc/exports

       /mnt/nfs_share  client_IP_1 (re,sync,no_subtree_check)
```

 . rw: Stands for Read/Write.
 . sync: Requires changes to be written to the disk before they are applied.
 . No_subtree_check: Eliminates subtree checking.


- nfs 서버 재시작

```bash
    $ sudo exportfs -a
    $ sudo systemctl restart nfs-kernel-server
```

- 만약 방화벽이 있다면

```bash
    $ sudo ufw allow from 192.168.0.0/24 to any port nfs
    $ sudo ufw enable
    $ sudo ufw status
```

## 마운트하려는 원격지 컴퓨터에서 NFS 클라이언트 프로그램 설치

- Install

```bash
    $ sudo apt update
    $ sudo apt install nfs-common
```

- Make mount folder

```bash
    $ sudo mkdir -p /mnt/nfs_clientshare
```

- Mount

```bash
    $ sudo mount 192.168.0.70:/mnt/nfs_share  /mnt/nfs_clientshare

    $ cd /mnt/nfs_share
    $ touch file1.txt file2.txt file3.txt

    $ ls -al /mnt/nfs_clientshare/

        drwxrwxrwx 2 nobody nogroup 4096  8월 16 17:31 .
        drwxr-xr-x 4 root   root    4096  8월 16 17:29 ..
        -rw-rw-r-- 1 jpark  jpark      0  8월 16 17:31 f1.txt
        -rw-rw-r-- 1 jpark  jpark      0  8월 16 17:31 f2.txt
        -rw-rw-r-- 1 jpark  jpark      0  8월 16 17:31 f3.txt

```



python setup.py install


```python
from pyNfsClient import (Portmap, Mount, NFSv3, MNT3_OK, NFS_PROGRAM,
                       NFS_V3, NFS3_OK, DATA_SYNC)

# variable preparation
host = "192.221.4.119"
mount_path = "/nfsshare"

auth = {"flavor": 1,
        "machine_name": "host1",
        "uid": 0,
        "gid": 0,
        "aux_gid": list(),
        }

# portmap initialization
portmap = Portmap(host, timeout=3600)
portmap.connect()

# mount initialization
mnt_port = portmap.getport(Mount.program, Mount.program_version)
mount = Mount(host=host, port=mnt_port, timeout=3600)
mount.connect()

# do mount
mnt_res =mount.mnt(mount_path, auth)
if mnt_res["status"] == MNT3_OK:
    root_fh =mnt_res["mountinfo"]["fhandle"]
    try:
        nfs_port =portmap.getport(NFS_PROGRAM, NFS_V3)
        # nfs actions
        nfs3 =NFSv3(host, nfs_port, 3600)
        nfs3.connect()
        lookup_res = nfs3.lookup(root_fh, "file.txt", auth)
        if lookup_res["status"] == NFS3_OK:
            fh = lookup_res["resok"]["object"]["data"]
            write_res = nfs3.write(fh, offset=0, count=11, content="Sample text",
                                   stable_how=DATA_SYNC, auth=auth)
            if write_res["status"] == NFS3_OK:
                read_res = nfs3.read(fh, offset=0, auth=auth)
                if read_res["status"] == NFS3_OK:
                    read_content = str(read_res["resok"]["data"], encoding="utf-8")
                    assert read_content.startswith("Sample text")
            else:
                print("write failed")
        else:
            print("Lookup failed")
    finally:
        if nfs3:
            nfs3.disconnect()
        mount.umnt(mount_path, auth)
        mount.disconnect()
        portmap.disconnect()
else:
    mount.disconnect()
    portmap.disconnect()
```
