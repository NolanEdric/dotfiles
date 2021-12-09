IP=$(ip -4 a show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
HOSTNAME=${1:-tidu-wsl}

if [ -n "$(grep $HOSTNAME /etc/hosts)" ]; then
    echo "$HOSTNAME already exists : $(grep $HOSTNAME $ETC_HOSTS)"
else
    # echo '$HOSTS_LINE' >> /etc/hosts

    if [ -n "$(grep $HOSTNAME /etc/hosts)" ]; then
        echo "$HOSTNAME was added succesfully \n $(grep $HOSTNAME /etc/hosts)"
    else
        echo "Failed to Add $HOSTNAME, Try again!"
    fi
fi
