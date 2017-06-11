#!/bin/sh
echo "Starting..."
echo $@ > /home/foo/.config/openbox/autostart
chown foo:foo /home/foo/.config/openbox/autostart && chmod +x /home/foo/.config/openbox/autostart

/usr/bin/supervisord --nodaemon