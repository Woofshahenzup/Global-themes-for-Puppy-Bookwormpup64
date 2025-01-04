#!/bin/bash -x

# Directorios de origen y destino
ORIGEN="/root/.icons/panel-icons"
DESTINO="/usr/share/pixmaps/puppy"
icon_theme=$(grep 'gtk-icon-theme-name' ~/.gtkrc-2.0 | cut -d'=' -f2 | tr -d ' ' | sed 's/"//g')
icon_name="zoom"  # Cambia esto al nombre del icono que deseas usar
# Ruta completa al icono
#icon_path=$(find /usr/share/icons/$icon_theme -type f -name "$icon_name.*" | head -n 1)  
icon_path=$(locate -r /usr/share/icons/$icon_theme/ $icon_name\..* | head -n 1)
# Verificar existencia de directorio de destino
if [ ! -d "$DESTINO" ]; then
    echo "Error: Directorio de destino no encontrado."
    exit 1
fi

# Función para crear enlaces simbólicos del tema seleccionado
crear_enlaces() {
    TEMA_SELECCIONADO=$1
    ICONOS="$ORIGEN/$TEMA_SELECCIONADO"
    
    # Iterar sobre los iconos del tema seleccionado
    for ICONO in "$ICONOS"/*.svg "$ICONOS"/*.png; do
        if [ -f "$ICONO" ]; then
            NOMBRE_ICONO=$(basename "$ICONO")
            ln -sf "$ICONO" "$DESTINO/$NOMBRE_ICONO"
        fi
    done 
   

  rjwm.sh 
pid_pa_applet=$(pgrep -f "pa-applet")
pid_firewallstatus=$(pgrep -f "firewallstatus")
pid_connman=$(pgrep -f "connman-ui-gkt")
pid_shortcuts=$(pgrep -f "shortcuts.sh")
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
    yad --title="Enlaces Creados" --text="¡Enlaces simbólicos creados exitosamente!" --window-icon="$icon_path" --center --width=300 --timeout=1 --no-buttons --no-mouse
}

# Mostrar la lista de temas en una ventana de selección
TEMA_SELECCIONADO=$(ls -d "$ORIGEN"/*/ | xargs -n 1 basename | yad --title="Iconos del panel" --window-icon="$icon_path" --posx=950 --posy=40 --width=300 --height=300 --list --column="Temas")



# Verificar si se seleccionó un tema
if [ -n "$TEMA_SELECCIONADO" ]; then
    # Extraer el nombre del tema eliminando el separador '|'
    TEMA=$(echo "$TEMA_SELECCIONADO" | cut -d '|' -f 1)
    
    # Llamar a la función para crear los enlaces simbólicos
    crear_enlaces "$TEMA"
fi


