x=1
while [ $x -le 45 ]
do
sleep 2
echo "Running $x times" >> script.log
echo "TorrentID: $torrentid" >> script.log
line=$(/usr/local/bin/deluge-console "connect 127.0.0.1:<port> <user> <pass>; info" $1 | grep "Tracker status")
echo $line >> script.log
case "$line" in
*unregistered*|*Sent*)
eval /usr/local/bin/deluge-console "connect 127.0.0.1:<port> <user> <pass>\; update-tracker '$torrentid'";;
*)
echo "Found working torrent: $torrentname $torrentpath $torrentid" >> script.log
exit 1;;
esac
x=$(( $x + 1 ))
done
