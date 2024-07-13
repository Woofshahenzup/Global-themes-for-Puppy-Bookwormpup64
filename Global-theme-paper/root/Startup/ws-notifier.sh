#! /usr/bin/env bash

############# DEBUGGING ################################################

#trap 'printf "\n" ; s=$?; echo >&2 "$0: Exit code on line "$LINENO": $BASH_COMMAND" ; exit $s ;' ERR
set -eou pipefail
#set -x

trap 'on_exit' EXIT


############# FUNCTIONS #################################################

# Get the Virtual Workspace
function get_virtual_desktop(){


    # Get the Virtual Desktop number
    local vd="$(wmctrl -d | grep "*" | awk '{ printf("%s", $1) }')"
    
    # print the Virtual Desktop number
    printf "%s" "$vd"
    

}



############ SCRIPT STARTS DOING THINGS #######################################

export script_pid=$$

# create a FIFO file, used to manage the I/O redirection from shell
export PIPE="$(mktemp -u --tmpdir ${0##*/}.XXXXXXXX)"
mkfifo "$PIPE"

# attach a file descriptor to the file
exec 3<> $PIPE
# add handler to manage process shutdown, I'm not sure if this function
# can be declared before creating the named pipe, and associating it to the FD 3
# so we leave it here for that reason
function on_exit() {
    
    rm -f "$PIPE"

}

export -f on_exit

function on_click(){

    kill -9 "$YAD_PID"
    kill -9 "$script_pid"
    rm -f "$PIPE"
    
    exit 0
}

export -f on_click

# Indicator or Notification Icon, it shows the tray being currently used
ws_icon=""
# Notification icons directory location
dir_icon="/root/.icons/ws-numbers"

# An associative array to help choose the proper notification icon
declare -A wsi
wsi["0"]="we_01.svg"
wsi["1"]="we_02.svg"
wsi["2"]="we_03.svg"
wsi["3"]="we_04.svg"
wsi["4"]="we_05.svg"
wsi["5"]="we_06.svg"
wsi["6"]="we_07.svg"
wsi["7"]="we_08.svg"
wsi["8"]="we_09.svg"
wsi["9"]="we_10.svg"

# The work space being used when the script is launched
current_workspace="$(get_virtual_desktop)"
# set the icon to the corresponding working space
ws_icon="${wsi[$current_workspace]}"

tooltip_ws=$(($current_workspace + 1))

# Create the notification icon using yad
yad --notification                  \
    --listen                        \
    --icon-size=48                  \
    --image="${dir_icon}/${ws_icon}"\
    --text="Workspace $tooltip_ws"   \
    --command="bash -c on_click" <&3 &

# update the icon by constatly checking any changes in the working space
while true ; do
    
    new_workspace="$(get_virtual_desktop)"
    
    tooltip_ws=$(($new_workspace + 1))
    
    if [[ $new_workspace -gt 9 ]] ; then
        
        ws_icon="error.svg"
        
        echo "icon:$dir_icon/$ws_icon" >> "$PIPE"
        
        echo "tooltip:workspace $tooltip_ws" >> "$PIPE"
        
        echo "action:bash -c on_click" >> "$PIPE"
        
    fi
    
    if [[ $current_workspace -ne $new_workspace ]]; then
        
        ws_icon="${wsi[$new_workspace]}"
        
        echo "icon:$dir_icon/$ws_icon" >> "$PIPE"
        
        echo "tooltip:workspace $tooltip_ws" >> "$PIPE"
        
        echo "action:bash -c on_click" >> "$PIPE"
        
        
    fi
    
    current_workspace="$new_workspace"
    
    sleep 2s  # Agregamos un retraso adicional antes de volver a verificar el cambio de espacio de trabajo
    
done

exit 0
