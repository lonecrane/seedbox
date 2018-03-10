#!/bin/bash
set -x
exec >/tmp/script$$.output 2>&1

torrentid=$1
torrentname=$2
torrentpath=$3
echo "Torrent Details: " "$torrentname" "$torrentpath" "$torrentid"  >> /tmp/de_execute_script_111.log

#此处替换为实际的用户名
xxx=???
SOURCE_TORR=/media/md3/$xxx/.config/deluge/state
DEST_TORR=/media/md3/$xxx/torrent/completed

echo `pwd`  >> /tmp/de_execute_script_111.log
cp $SOURCE_TORR/$torrentid.torrent $DEST_TORR/$torrentid.torrent  >> /tmp/de_execute_script_111.log
