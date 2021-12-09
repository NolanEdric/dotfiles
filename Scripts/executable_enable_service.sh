file=~/scripts/enabled_services.txt

if ! cat $file | grep -q "$1$"; then
    echo $1 >> $file
fi