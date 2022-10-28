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

# Work-specific
alias kadanza="gnome-terminal --tab --title=\"LAYOUT MANAGER\" --command=\"bash -c 'cd /var/home/rumen/storage/projects/kadanza-saas/kadanza-layoutmanager; ./run.sh; $SHELL'\" --tab --title=\"INFRA\" --command=\"bash -c 'cd /var/home/rumen/storage/projects/kadanza-saas/kadanza-saas-infra/local; docker-compose up; $SHELL'\" --tab --title=\"CORE\" --command=\"bash -c 'cd /var/home/rumen/storage/projects/kadanza-saas/kadanza-core; docker-compose up; $SHELL'\" --tab --title=\"PLATFORM\" --command=\"bash -c 'cd /var/home/rumen/storage/projects/kadanza-saas/kadanza-platform; docker-compose --env-file .env.local up; $SHELL'\""
