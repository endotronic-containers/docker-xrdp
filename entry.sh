#!/bin/bash
_term() { 
  echo "Caught SIGTERM signal! Sending SIGINT to $child"
  kill -INT "$child"

  while kill -0 "$child" 2> /dev/null; do
    sleep 0.25
  done
}

trap _term SIGTERM
trap _term SIGINT

echo "Starting..."
echo "Resolution is $VNC_RES"
echo "Password is $PASSWORD"
echo $@ > /home/foo/.config/openbox/autostart
chown foo:foo /home/foo/.config/openbox/autostart && chmod +x /home/foo/.config/openbox/autostart

/usr/bin/supervisord --nodaemon &
child=$! 
wait "$child"