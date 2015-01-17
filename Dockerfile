FROM docker.io/ubuntu:vivid
MAINTAINER Edgard Castro <castro@edgard.org>

# Keep image updated
ENV REFRESHED_AT 2015-07-28-05-16Z

# Add repositories and update base
RUN echo "deb http://archive.ubuntu.com/ubuntu/ vivid main restricted universe multiverse" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu/ vivid-updates main restricted universe multiverse" >> /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu/ vivid-backports main restricted universe multiverse" >> /etc/apt/sources.list \
  && echo "deb http://security.ubuntu.com/ubuntu vivid-security main restricted universe multiverse" >> /etc/apt/sources.list \
  && apt-get update -q \
  && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -qy

# Install software
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy --no-install-recommends supervisor ca-certificates unzip unrar rtorrent nginx curl procps ffmpeg mediainfo php5-fpm php5-cli php5-geoip \
  && mkdir -p /var/www \
  && curl -Ls http://dl.bintray.com/novik65/generic/rutorrent-3.6.tar.gz | tar zxf - -C /var/www \
  && curl -Ls http://dl.bintray.com/novik65/generic/plugins-3.6.tar.gz | tar zxf - -C /var/www/rutorrent \
  && chown www-data:www-data -R /var/www \
  && apt-get clean \
  && rm -rf /var/lib/apt /tmp/* /var/tmp/*

# Add custom files
COPY files/root /

# Start command
CMD ["/start"]
