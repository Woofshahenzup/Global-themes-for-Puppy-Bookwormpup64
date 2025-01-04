#!/bin/bash -x
pkill yad &
# Mata los procesos relacionados con pa-applet y connman-ui-gtk
pkill -f 'pa-applet|connman-ui-gtk' 
pa-applet &
connman-ui-gtk &
#exec /root/Startup/keyhint-notification.sh &
# Reinicia jwm
jwm -restart
