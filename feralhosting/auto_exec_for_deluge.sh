#!/bin/bash
set -x
exec >> ~/tmp/script-auto-exec-deluge-$$.output 2>&1

torrentid=$1
torrentname=$2
torrentpath=$3
echo "Torrent Details: " "$torrentname" "$torrentpath" "$torrentid"  >> ~/tmp/script-auto-exec-deluge-$$.log

#此处替换为实际的用户名
xxx=???
SOURCE_TORR=/media/md3/$xxx/.config/deluge/state
DEST_TORR=/media/md3/$xxx/torrent/completed

echo `pwd`  >> /tmp/de_execute_script_111.log
cp $SOURCE_TORR/$torrentid.torrent $DEST_TORR-for-rt/$torrentid.torrent  >> ~/tmp/script-auto-exec-deluge-$$.log
#cp $SOURCE_TORR/$torrentid.torrent $DEST_TORR-bak/$torrentid.torrent
#cp $SOURCE_TORR/$torrentid.torrent $DEST_TORR-for-qb/$torrentid.torrent
