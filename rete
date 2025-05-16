#!/bin/bash

# Aggiunta connessione Ethernet con IP statico
nmcli connection add type ethernet ifname eth0 con-name static-eth0 autoconnect yes \
    ipv4.method manual ipv4.addresses 192.168.1.100/24 ipv4.gateway 192.168.1.1

# Aggiunta connessione Wi-Fi con IP statico
nmcli connection add type wifi ifname wlan0 con-name wificasa autoconnect yes \
    ssid TP-LINK_2.4GHz_E0FF27 \
    wifi-sec.key-mgmt wpa-psk wifi-sec.psk "gambacorta" \
    ipv4.method manual ipv4.addresses 192.168.1.200/24 ipv4.gateway 192.168.1.1
