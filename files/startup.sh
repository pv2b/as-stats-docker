#!/bin/bash

if ! [ -d /data/as-stats ]; then
  echo "You must mount a volume to /data/as-stats!"
  exit 1
fi

mkdir -p /data/as-stats/{conf,rrd}

if ! [ -f /data/as-stats/conf/knownlinks ]; then
  echo "You must put a knownlinks file in /data/as-stats/conf/knownlinks!"
  exit 1
fi

# Set time zone
if ! [ -v TZ ] ; then
  TZ=UTC
fi
cp "/usr/share/zoneinfo/$TZ" /etc/localtime
echo "$TZ" > /etc/timezone

# persistante config file web ui
if [ -f /data/as-stats/config.inc ] ; then
  rm /var/www/config.inc
else
  mv /var/www/config.inc /data/as-stats/config.inc
fi
ln -s /data/as-stats/config.inc /var/www/config.inc

# hand over to supervisord
exec /usr/bin/supervisord -n -c /etc/supervisord.conf