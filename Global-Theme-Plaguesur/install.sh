#!/bin/sh -x

APPDIR="`dirname $0`"
[ "$APPDIR" = "." ] && APPDIR="`pwd`"
export APPDIR="$APPDIR"
message="<span font='20' color='#A7DBFC'> PRESS THE APPLY BUTTON OF GTK THEME SWITCHER, THESE CHANGES CANNOT BE UNDONE. </span> "
tar -xf $APPDIR/tar-themes/macOS-dark.tar.gz -C /usr/share/themes &
tar -xf $APPDIR/tar-themes/PlagueSur.tar.gz -C /usr/share/icons/ &
cp -r $APPDIR/var / &
cp -r $APPDIR/root / &
cp -r $APPDIR/usr / &
cp -r $APPDIR/etc / &
cp -r $APPDIR/home/spot/spot.png /home/spot & 
sleep 01
ln -sf /root/.icons/panel-icons/plaguesur/*.* /usr/share/pixmaps/puppy &&
#sleep 01
#cp -r /usr/local/jwmdesk/jwm_button_themes/BigsurSamcat/. /usr/share/pixmaps &
sleep 01
chmod -x /usr/local/jwmdesk/jwmdesk
rm /root/.config/autostart/synapse.desktop 
rm /etc/xdg/autostart/parcellite-startup.desktop 
rm /root/Startup/gatotray.bin64 #fossapup
rm /root/.config/autostart/clipit-startup.desktop #fossapup

yad --no-buttons --on-top \
--text="$message" \
--text-align="center"  --undecorated --width=800 --height=20 \
--image="/usr/share/icons/Paper/32x32/actions/help-info.png" \ &
pid_pa_applet=$(pgrep -f "pa-applet")
pid_firewallstatus=$(pgrep -f "firewallstatus")
pid_connman=$(pgrep -f "connman-ui-gkt")
# Matar los procesos
kill -9 $pid_connman
kill -9 $pid_pa_applet
kill -9 $pid_firewallstatus
killall freememapplet_tray
sleep 01
# Reiniciar los procesos (reemplaza con los comandos reales)
pa-applet 2>/dev/null &
connman-ui-gtk &
firewallstatus &
freememapplet_tray &
jwm -restart &
/usr/local/jwmdesk/ptheme_gtk &&
restartwm
