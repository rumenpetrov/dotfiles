# General
alias c="clear"
alias ll="ls -alF"
alias sz="du -had 1 | sort -rh"
alias disks="df -hT"
alias temp="paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/'"
alias livetemp="watch \"paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/'\""

# Location
alias storage="cd ~/storage"
alias projects="cd ~/storage/projects"
alias www="cd ~/storage/projects/web"

# Containers
alias sel-st="sestatus"
alias sel-enforce-off="sudo setenforce 0"
