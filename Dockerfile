FROM ubuntu:jammy

ENV DEBIAN_FRONTEND=noninteractive

## add dependencies
RUN \
    apt update && \
    apt install -y \
    wget \
    curl \
    libbluray2 \
    libelf1 \
    libexpat1 \
    libllvm15 \
    libmp3lame0 \
    libopenmpt0 \
    libopus0 \
    libpciaccess0 \
    libtheora0 \
    libvorbis0a \
    libvorbisenc2 \
    libvpx7 \
    libwebp7 \
    libwebpmux3 \
    libx11-xcb1 \
    libx264-163 \
    libx265-199 \
    libxcb-dri2-0 \
    libxcb-dri3-0 \
    libxcb-present0 \
    libxcb-randr0 \
    libxcb-shm0 \
    libxcb-sync1 \
    libxcb-xfixes0 \
    libxcb1 \
    libxshmfence1 \
    libzvbi0 \
    ocl-icd-libopencl1 \
    libopencl-1.1-1 \
    libopencl-1.2-1

## install ffmpeg
RUN \
    wget https://repo.jellyfin.org/files/ffmpeg/ubuntu/latest-6.x/amd64/jellyfin-ffmpeg6_6.0.1-8-jammy_amd64.deb && \
    dpkg -i *.deb && \
    mv /usr/lib/jellyfin-ffmpeg/ffmpeg /usr/bin && \
    chmod +x /usr/bin/ffmpeg && \ 
    rm *.deb

## install mesa=23.2.1 from jammy repo
RUN \
    apt install -y vainfo mesa-va-drivers=23.2.1-1ubuntu3.1~22.04.3 && \
    apt install -y mesa-vulkan-drivers=23.2.1-1ubuntu3.1~22.04.3 && \
    apt install -y vulkan-tools=1.3.204.0+dfsg1-1

ADD get-videos.sh /opt

RUN \
    chmod +x /opt/get-videos.sh

## cleanup
RUN \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/apt/* /tmp/* /var/tmp/* /usr/share/doc/*