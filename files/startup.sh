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

# populate default config file for web ui if missing
if ! [ -f /data/as-stats/config.inc ] ; then
  cp /var/www/config.inc.dist /data/as-stats/config.inc
fi

# Set time zone
if ! [ -v TZ ] ; then
  TZ=UTC
fi
cp "/usr/share/zoneinfo/$TZ" /etc/localtime
echo "$TZ" > /etc/timezone

# hand over to supervisord
exec /usr/bin/supervisord -n -c /etc/supervisord.conf