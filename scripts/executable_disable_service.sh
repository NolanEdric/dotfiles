file=~/scripts/enabled_services.txt

sed -i "/$1$/d" $file

sudo service "$1" stop