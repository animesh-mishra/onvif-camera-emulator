FROM ubuntu:20.04 as build

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y
RUN apt install python3-gi -y \
    # gstreamer-1.0 \
    libgstrtspserver-1.0-dev \
    gstreamer1.0-rtsp \
    gstreamer1.0-plugins-ugly -y

RUN apt install iproute2 -y

RUN mkdir /onvif_camera
WORKDIR /onvif_camera

ADD onvif_srvd ./onvif_srvd/
ADD scripts ./scripts/
ADD wsdd ./wsdd/
ADD rtsp-feed.py .

ENTRYPOINT ["/onvif_camera/scripts/start-onvif-camera.sh" ]
CMD ["wlp2s0"]