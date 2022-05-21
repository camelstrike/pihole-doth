#!/bin/sh

# Generate template for our domain
envsubst '${ADLISTS_URL}','${WHITELIST_URL}','${REGEX_WHITELIST_URL}','${BLACKLIST_URL}','${REGEX_BLACKLIST_URL}' \
< /tmp/pihole-updatelists.conf.template > /etc/pihole-updatelists/pihole-updatelists.conf

# Start pihole
/s6-init
