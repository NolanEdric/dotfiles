#! /usr/bin/env sh

IP_FILE=/tmp/ip.json
IPv4=$(ip -4 a show enp4s0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
IPv6=$(ip -6 a show enp4s0 | grep -oP '(?<=inet6\s)[^\s]+(?=\/128+)')
IP="{ \"ipv4\": \"$IPv4\", \"ipv6\": \"$IPv6\" }"

update_ip() {
  curl -su tidunguyen:Sv4fnexVFfaiKp "https://api.dynu.com/nic/update?hostname=tidu.giize.com&myip=$IPv4&myipv6=$IPv6"
  echo "$IP" >"$IP_FILE"
}

if [ ! -f "$IP_FILE" ]; then
  echo "no ip file"
  update_ip
else
  _IP=$(cat "$IP_FILE")
  if [ "$IP" != "$_IP" ]; then
    echo "ip file not match"
    update_ip
  else
    echo "ip file match"
  fi
fi
