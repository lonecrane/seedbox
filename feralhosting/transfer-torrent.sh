#!/bin/bash

# 以上传方式为例，在A机器上操作，将文件上传到B机器上
# A为LOCAL，B为DEST
DEST_USER=
DEST_HOST=
DEST_DATA='~/GGN/'
DEST_TORR='~/.fh-session/'
DEFAULT_TIME=600
xxx=???
#LOCAL_DATA=/media/md3/$xxx/private/deluge/data
LOCAL_DATA=/media/md3/$xxx/private/deluge/completed
#LOCAL_TORR=/media/md3/$xxx/private/deluge/torrents
#LOCAL_TORR=/media/md3/$xxx/.config/deluge/state
LOCAL_TORR=/media/md3/$xxx/torrent/completed


if [ "$#" -eq "1" ]; then
    echo "My first parameter is $1"
    DEFAULT_TIME=$1
fi

# 使shell将文件名的空格字符当作普通字符
IFS=$'\n'

count=0
# for i in `ls -Atr $LOCAL_DATA`;
for i in `find $LOCAL_DATA -maxdepth 1 -mindepth 1 -mmin -$DEFAULT_TIME`;
do 
echo "$i"
# scp -r -p -l $[55*1024*8] "$LOCAL_DATA/$i" $DEST_USER@$DEST_HOST:$DEST_DATA
# rsync -av --progress --bwlimit=51200 -e ssh ''"$LOCAL_DATA/$i"'' $DEST_USER@$DEST_HOST:$DEST_DATA
rsync -av --progress --bwlimit=51200 -e ssh ''"$i"'' $DEST_USER@$DEST_HOST:$DEST_DATA
count=$[ $count+1 ]
# if [[ $count -eq 1 ]]; then
#  break
# fi
done

# 未完成的种子文件推迟30分钟再同步，以免两主机同时下载
count=0
# for i in `ls -Atr $LOCAL_TORR`;
# for i in `find $LOCAL_TORR -maxdepth 1 -mindepth 1 -name *.torrent -mmin -$DEFAULT_TIME -mmin +30 -print0 | xargs -0 ls -atr`;
for i in `find $LOCAL_TORR -maxdepth 1 -mindepth 1 -name *.torrent -mmin -$DEFAULT_TIME -print0 | xargs -0 ls -atr`;
do 
echo "$i"
# scp -r -p -l $[55*1024*8] "$LOCAL_TORR/$i" $DEST_USER@$DEST_HOST:$DEST_TORR
# rsync -av --progress --bwlimit=51200 -e ssh ''"$LOCAL_TORR/$i"'' $DEST_USER@$DEST_HOST:$DEST_TORR
rsync -av --progress --bwlimit=51200 -e ssh ''"$i"'' $DEST_USER@$DEST_HOST:$DEST_TORR
count=$[ $count+1 ]
# if [[ $count -eq 1 ]]; then
#   break
# fi
done

# scp的参数
# -p, 保持子文件夹和文件的修改时间
# -l, 限速传输，单位为kbits/s
# scp不能增量传输，即使远方已经存在文件，仍然会传输一遍；rsync可以增量传输（据说是在二进制级别）

# rsync的参数：
# -v, --verbose 详细模式输出。
# -a, --archive 归档模式，表示以递归方式传输文件，并保持所有文件属性，等于-rlptgoD 
# -r, --recursive 对子目录以递归模式处理。
# -t, --times 保持文件时间信息。
# -p, --perms 保持文件权限。
