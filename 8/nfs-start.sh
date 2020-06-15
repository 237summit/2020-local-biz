#!/bin/bash
cat << END > /etc/exports
/sharedir/webdata    *(ro)
/sharedir/data   *(rw,sync,no_root_squash)
/sharedir/pv1        *(rw,sync,no_root_squash)
/sharedir/pv2        *(rw,sync,no_root_squash)
/sharedir/pv3        *(rw,sync,no_root_squash)
/sharedir/pv4        *(rw,sync,no_root_squash)
/sharedir/pva        *(rw,sync,no_root_squash)
/sharedir/pvb        *(rw,sync,no_root_squash)
/sharedir/pvc        *(rw,sync,no_root_squash)
/dynamicdir        *(rw,sync,no_root_squash)
END

systemctl start nfs-server && systemctl enable nfs-server

firewall-cmd --add-service=nfs
firewall-cmd --add-service=nfs --permanent

mkdir -p /dynamicdir /sharedir/{webdata,pv{1..4},data,pv{a..c}}

echo "<h1>TEST WEB</h1>"  > /sharedir/webdata/index.html

systemctl restart nfs-server && systemctl enable nfs-server
exportfs

