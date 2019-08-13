FROM scottyhardy/docker-wine

ENV TUFUSE_VERSION 1.60
ENV TUFUSE_LOCATION "http://www.tawbaware.com/tufuse.zip"

# Install sudo
RUN apt-get -y update &&  apt-get -y install --no-install-recommends sudo

# Allow wineuser to copy files as root
RUN echo "" >> /etc/sudoers
RUN echo "# User privilege specification" >> /etc/sudoers
RUN echo "wineuser    ALL=(ALL:ALL) NOPASSWD:/bin/cp" >> /etc/sudoers

# Download TuFuse
RUN wget -O /tmp/tufuse.zip "${TUFUSE_LOCATION}"

# Extract TuFuse
WORKDIR /home/wineuser
RUN mkdir -p /usr/share/tufuse
RUN unzip -d /usr/share/tufuse /tmp/tufuse.zip
RUN rm -f /tmp/tufuse.zip

CMD ["/usr/bin/wine", "/usr/share/tufuse/TuFuse.exe"]

