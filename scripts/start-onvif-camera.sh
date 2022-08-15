#!/bin/bash

interface=${1:-'eth0'}
directory=${2:-$(pwd)}
firmware_ver=${3:-"1.0"}

echo "interface: $interface, directory: $directory, firmware version: $firmware_ver"

if pgrep wsdd > /dev/null; then
    sudo pkill wsdd
fi

# Forcibly terminate.
if pgrep wsdd > /dev/null; then
    sudo pkill -9 wsdd
fi

# Ask onvif server nicely to terminate.
if pgrep onvif_srvd > /dev/null; then
    sudo pkill onvif_srvd
fi

# Forcibly terminate.
if pgrep onvif_srvd > /dev/null; then
    sudo pkill -9 onvif_srvd
fi

# Ask onvif server nicely to terminate.
if pgrep rtsp-feed.py > /dev/null; then
    sudo pkill rtsp-feed.py
fi

# Forcibly terminate.
if pgrep rtsp-feed.py > /dev/null; then
    sudo pkill -9 rtsp-feed.py
fi

ip4=$(/sbin/ip -o -4 addr list $interface | awk '{print $4}' | cut -d/ -f1)
if [ -z "$ip4" ]; then
    echo "Couldn't get the IP address for running ONVIF camera. Exiting now.."
    exit 1
fi

echo "Camera is running on IP: $ip4"

$directory/onvif_srvd/onvif_srvd  --ifs $interface --scope onvif://www.onvif.org/name/TestDev --scope onvif://www.onvif.org/Profile/S --name RTSP --width 1200 --height 900 --url rtsp://$ip4:8554/stream1 --type MPEG4 --firmware_ver $firmware_ver
$directory/wsdd/wsdd  --if_name $interface --type tdn:NetworkVideoTransmitter --xaddr http://%s:1000/onvif/device_service --scope "onvif://www.onvif.org/name/TestDev onvif://www.onvif.org/Profile/Streaming"
$directory/rtsp-feed.py