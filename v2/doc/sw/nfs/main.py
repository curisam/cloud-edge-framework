from pyNfsClient import (Portmap, Mount, NFSv3, MNT3_OK, NFS_PROGRAM,
                       NFS_V3, NFS3_OK, DATA_SYNC)

# variable preparation
host = "ketiabcs.iptime.org"
mount_path = "/dev0123456789"

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
