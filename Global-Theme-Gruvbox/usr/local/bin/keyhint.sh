#!/bin/sh 
icon_theme=$(grep 'gtk-icon-theme-name' ~/.gtkrc-2.0 | cut -d'=' -f2 | tr -d ' ' | sed 's/"//g')
icon_name="input-keyboard-symbolic"  # Cambia esto al nombre del icono que deseas usar

# Ruta completa al icono
#icon_path=$(find /usr/share/icons/$icon_theme -type f -name "$icon_name.*" | head -n 1)
icon_path=$(locate -r /usr/share/icons/$icon_theme/ $icon_name\..* | head -n 1)


yad --width=530 --height=650 \
--center \
--window-icon="$icon_path" \
--title="Keybindings" \
--no-buttons \
--list \
--column=Key: \
--column=Description: \
--column=Command: \
--timeout=60 \
--timeout-indicator=right \
"ESC" "close this app" "" \
"=" "modkey" "(set mod Mod4 4=JWM)" \
"A C S" "ALT. CTRL, SHIFT Keys" "" \
" + q" "Terminal" "(Default terminal)" \
"C + A + T" "Terminal" "(Default terminal)" \
"_RIGHT" "Application Menu" "(jwm menu)" \
" + w" "" "Default Broswer" \
" + e" "" "File Manager (Rox)" \
"alt+f4" "close active window" "(winclose)" \
"Print" "screenshot app" "(take a shot)" \
" + g" "text editor" "(geany)" \
" + a" "rjwm" "refresh jwm" \
" + y" "keyhint.sh" "show key bindings list" \
" + s" "shutdown-gui" "shutdown manager" \
" + up" "maximize window" "" \
" + down" "minimize window" "" \
" + left" "max window to left" "" \
" + right" "max window to right" "" \
"C + A + left" "move to left workspace" "" \
"C + A + right" "move to right workspace" "" \
" + A + left" "send window to left ws" "" \
" + A + right" "send window to right ws" "" \
" + #" "select the # workspace 1-6" "ex.  + 4"  \
"" "" " Window closed in 60 sec."\
