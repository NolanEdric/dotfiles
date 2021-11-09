#!/usr/bin/env zsh

# file=~/scripts/enabled_services.txt

# running_services=$(sudo service --status-all 2>/dev/null | grep +)

# cat $file | while read svc
# do
#     if ! grep -q "  $svc$" <<< "$running_services"; then
#         sudo service $svc start 1>/dev/null
#     fi
# done

enabled_svc=$(systemctl list-unit-files | awk -F '.' '/.service|.timer/ && /enabled/{print $1}' -)
running_svc=$(systemctl | awk -F '.' '/.service|.timer/ && /running/{print $1}' -)

comm -23 <(echo $enabled_svc) <(echo $running_svc) | while read svc
do
  sudo systemctl start $svc
done
