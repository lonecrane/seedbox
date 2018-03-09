# 以上传方式为例，在A机器上操作，将文件上传到B机器上
# A为LOCAL，B为DEST
LOCAL_DATA=/media/md3/xxx/private/deluge/data
LOCAL_TORR=/media/md3/xxx/private/deluge/torrents
DEST_USER=
DEST_HOST=
DEST_DIR='~/xxx/'

# 使shell将文件名的空格字符当作普通字符
IFS=$'\n'

count=0
for i in `ls -atr $LOCAL_DATA`;
do 
echo "$i"
# scp -r -p -l $[55*1024*8] "$LOCAL_DATA/$i" $DEST_USER@$DEST_HOST:$DEST_DIR
rsync -av --progress -e ssh ''"$LOCAL_DATA/$i"'' $DEST_USER@$DEST_HOST:$DEST_DIR
count=$[ $count+1 ]
# if [[ $count -eq 10 ]]; then
#  break
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
