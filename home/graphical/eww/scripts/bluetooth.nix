pkgs: let
  programs = with pkgs; [
    bluez
    gawk
    ripgrep
  ];
in
  pkgs.writeShellScript "bluetooth" ''
    export PATH=$PATH:${pkgs.lib.makeBinPath programs}

    declare -A baticon=([10]="󰁺" [20]="󰁻" [30]="󰁼" [40]="󰁽" [50]="󰁾" [60]="󰁿" [70]="󰂀" [80]="󰂁" [90]="󰂂" [100]="󰁹")

    powered=$(bluetoothctl show | rg Powered | cut -f 2- -d ' ')
    status=$(bluetoothctl info)
    battery=$(echo "$status" | tail -1 | awk '{print $4 }' | tr -d '()')
    name=$(echo "$status" | rg Name | cut -f 2- -d ' ')


    if [[ $powered == "yes" ]]; then
      if [[ $status != "Missing device address argument" ]]; then
        if [[ $battery -le 100 && $battery -ge 0 ]]; then
          text="$name ''${baticon[$battery]}"
        else
          text="$name"
        fi

        icon=""
        color="#b4befe"
      else
        icon=""
        text="Disconnected"
        color="#45475a"
      fi
    else
      icon=""
      text="Bluetooth off"
      color="#45475a"
    fi

    if [[ $1 == "color" ]]; then
      echo $color
    elif [[ $1 == "text" ]]; then
    	echo $text
    elif [[ $1 == "icon" ]]; then
    	echo $icon
    fi
  ''