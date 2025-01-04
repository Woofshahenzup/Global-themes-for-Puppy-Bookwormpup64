#!/bin/bash
icon_theme=$(grep 'gtk-icon-theme-name' ~/.gtkrc-2.0 | cut -d'=' -f2 | tr -d ' ' | sed 's/"//g')
icon_name="input-keyboard"  # Cambia esto al nombre del icono que deseas usar

# Ruta completa al icono
#icon_path=$(find /usr/share/icons/$icon_theme -type f -name "$icon_name.*" | head -n 1)
icon_path=$(locate -r /usr/share/icons/$icon_theme/ $icon_name\..* | head -n 1)

if [ -n "$icon_path" ]; then
    yad --notification --text="$(gettext 'Shortcuts')" --icon-size=42 --image="$icon_path" --command=/usr/local/bin/keyhint.sh
else
    echo "No se encontró el icono $icon_name en el tema de iconos actual."
fi
