#!/bin/bash

# lance AS-Stats
nohup /root/run-asstatd.sh &

# Mise à l'heure
if [[ -n $TZ ]] ; then
  cp "/usr/share/zoneinfo/$TZ" /etc/localtime
  echo "$TZ" > /etc/timezone
else
  cp /usr/share/zoneinfo/UTC /etc/localtime
  echo UTC > /etc/timezone
fi

# persistante config file web ui
if [ -f /data/as-stats/config.inc ] ; then
  rm /var/www/config.inc
  ln -s /data/as-stats/config.inc /var/www/config.inc
else
  mv /var/www/config.inc /data/as-stats/config.inc
  ln -s /data/as-stats/config.inc /var/www/config.inc
fi