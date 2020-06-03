#!/usr/bin/env sh

# set the password from environment variable
export DOLLAR='$'
envsubst < base-nginx.conf >  /usr/local/nginx/conf/nginx.conf

# start stunnel
/usr/bin/stunnel &

# append nginx conf with RTMP Configuration
python3 /rtmp-conf-generator.py /rtmp-configuation.json >> /usr/local/nginx/conf/nginx.conf
if [ $? -ne 0 ]; then
  echo "ERROR encountered when generating RTMP configuration."
  exit 1
fi

# finally, launch nginx
/usr/local/nginx/sbin/nginx -g "daemon off;"
