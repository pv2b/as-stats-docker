#!/bin/bash

# build argument list for asstatd.pl
args=()
if [[ $NETFLOW == 1 ]] ; then
  # NetFlow is enabled by default, running on a default port so we don't need to add command line to enable it
  if [[ -v NETFLOW_PORT ]] ; then
    # Set NetFlow port if a custom port is required
    args+=("-p" "$NETFLOW_PORT")
  fi
else
  # Disable NetFlow
  args+=("-p" "0")
fi

if [[ $SFLOW == 1 ]] ; then
  # sFlow is enabled by default, running on a default port so we don't need to add command line to enable it
  if [[ -v SFLOW_PORT ]] ; then
    # Set sFlow port if a custom port is required
    args+=("-P" "$SFLOW_PORT")
  fi

  # Own AS Number is required for sflow
  args+=("-a" "$SFLOW_ASN")

  # Enable peer-as statistics if requested
  if [[ $SFLOW_PEERAS == 1 ]] ; then
    args+=("-n")
  fi
else
  # Disable sFlow
  args+=("-P" "0")
fi

# Enable IP<->ASN mapping with provided JSON file path
if [[ -v IP2AS_PATH ]]; then
  args+=("-m" "$IP2AS_PATH")
fi

# Run AS-Stats
exec /root/AS-Stats/bin/asstatd.pl -r /data/as-stats/rrd -k /data/as-stats/conf/knownlinks "${args[@]}"