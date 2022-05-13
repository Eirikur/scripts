#!/bin/bash
sudo su
bash <(curl -Ss https://my-netdata.io/kickstart.sh) --dont-wait --dont-start-it

mkdir -p /etc/netdata

cat >/etc/netdata/netdata.conf <<EOF
[global]
  memory mode = none
[web]
  mode = none
EOF

cat >/etc/netdata/stream.conf <<EOF
[stream]
  enabled = yes
  destination = master-netdata
  api key = API KEY
EOF

systemctl enable netdata
systemctl start netdata

