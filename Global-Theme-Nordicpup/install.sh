#!/bin/sh -x

APPDIR="`dirname $0`"
[ "$APPDIR" = "." ] && APPDIR="`pwd`"
export APPDIR="$APPDIR"
message="<span font='20' color='#A7DBFC'> PRESS THE APPLY BUTTON OF GTK THEME SWITCHER, THESE CHANGES CANNOT BE UNDONE. </span> "
tar -xf $APPDIR/tar-themes/Nordic-v40.tar.gz -C /usr/share/themes &
tar -xf $APPDIR/tar-themes/Nordic-bluish-accent.tar.gz -C /usr/share/themes &
tar -xf $APPDIR/tar-themes/Bonny-Dark-Icons.tar.gz -C /usr/share/icons/ &
cp -r $APPDIR/var / &&
cp -r $APPDIR/root / &&
cp -r $APPDIR/usr / &&
cp -r $APPDIR/etc / &&
cp -r $APPDIR/home/spot/.* /home/spot && 
sleep 01
ln -sf /root/.icons/panel-icons/bonny-dark/*.* /usr/share/pixmaps/puppy &&
#cp -r /usr/local/jwmdesk/jwm_button_themes/nord/. /usr/share/pixmaps &
sleep 01
rm /usr/share/applications/jwmdesk.desktop
rm /root/.config/autostart/synapse.desktop 
rm /etc/xdg/autostart/parcellite-startup.desktop 
rm /root/Startup/gatotray.bin64 #fossapup
rm /root/.config/autostart/clipit-startup.desktop #fossapup
sleep 01
yad --no-buttons --on-top \
--text="$message" \
--text-align="center" --undecorated --width=800 --height=20 \
--image="/usr/share/icons/Bonny-Dark-Icons/status/64/dialog-warning.svg" \ &
sleep 01
pkill pa-applet.bin &
pkill connman-ui-gtk &
pa-applet &
connman-ui-gtk &
jwm -restart &
/usr/local/jwmdesk/ptheme_gtk &&
restartwm
