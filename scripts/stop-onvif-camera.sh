#!/bin/bash
# Ask wsdd nicely to terminate.
if pgrep wsdd > /dev/null; then
    echo "Asking wsdd nicely to terminate"
    sudo pkill wsdd
fi

# Forcibly terminate.
if pgrep wsdd > /dev/null; then
    echo "Forcefully terminating wsdd"
    sudo pkill -9 wsdd
fi

# Ask onvif server nicely to terminate.
if pgrep onvif_srvd > /dev/null; then
    echo "Asking onvif server nicely to terminate"
    sudo pkill onvif_srvd
fi

# Forcibly terminate.
if pgrep onvif_srvd > /dev/null; then
    echo "Forcefully asking onvif_srvd to terminate"
    sudo pkill -9 onvif_srvd
fi

# Ask onvif server nicely to terminate.
if pgrep rtsp-feed.py > /dev/null; then
    echo "Asking rtsp server nicely to terminate"
    sudo pkill rtsp-feed.py
fi

# Forcibly terminate.
if pgrep rtsp-feed.py > /dev/null; then
    echo " Forcefully asking rtsp server to terminate"
    sudo pkill -9 rtsp-feed.py
fi
