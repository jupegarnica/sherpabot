# some vars
HUBOT_ADAPTER='twitter'
HUBOT_NAME='sherpaSiri'
#HUBOT_REPO='https://github.com/matthutchinson/henshall.git'
# HUBOT_CAMPFIRE_ACCOUNT=''
# HUBOT_CAMPFIRE_ROOMS=''
# HUBOT_CAMPFIRE_TOKEN=''
# HUBOT_IRC_SERVER='irc.perl.org'
# HUBOT_IRC_ROOMS='#henshall'

# install build essentials, redis (for the brain) and git
# apt-get update
# apt-get install build-essential git-core redis-server python-software-properties software-properties-common --assume-yes

# install (latest) node (builds from source (slow) and includes npm)
# add-apt-repository -y ppa:chris-lea/node.js
# apt-get update
# apt-get install nodejs --assume-yes

# install coffee-script
# npm install -g coffee-script

# clone hubot from git
# git clone $HUBOT_REPO /usr/local/hubot
# cd /usr/local/hubot
# npm install

# hubot user
adduser --disabled-password --gecos "" hubot

touch /var/log/hubot.log
chown hubot:hubot /var/log/hubot.log

# upstart script
cat <<EOF > /etc/init/hubot.conf
description "Hubot"

# adapter variables
export HUBOT_TWITTER_KEY="5b3fhh8M7C3aeuW7Q988Rg"
export HUBOT_TWITTER_SECRET="p2dhNvD3StT5KtuUwgB3zavvm2hncWcT782rUFx68"
export HUBOT_TWITTER_TOKEN="2309221603-Yp9GapjNfGnT9z3naLvV2Az87TkviJrO3aDaflm"
export HUBOT_TWITTER_TOKEN_SECRET="ZQ0vZV3xszWUVGRxmZT0ostnJFB4Fo906QLVZgtqSkEAB"
export HUBOT_WOLFRAM_APPID="QTL64Q-4JKEREJVTT"
export REDISTOGO_URL="redis://localhost:6379"

# Subscribe to these upstart events
# This will make Hubot start on system boot
start on filesystem or runlevel [2345]
stop on runlevel [!2345]

# Path to Hubot installation
export HUBOT_DIR='/home/jupegarnica/sherpabot'
export HUBOT_LOG_FILE='/var/log/hubot.log'
export HUBOT_BIN='bin/hubot'
export HUBOT_USER='hubot'
export HUBOT_ADAPTER='$HUBOT_ADAPTER'
export HUBOT_NAME='$HUBOT_NAME'

# Keep the process alive, limit to 5 restarts in 60s
respawn
respawn limit 5 60

exec start-stop-daemon --start --chuid \$HUBOT_USER --chdir \$HUBOT_DIR \
  --exec \$HUBOT_DIR/\$HUBOT_BIN -- --name \$HUBOT_NAME --adapter \$HUBOT_ADAPTER >> \$HUBOT_LOG_FILE 2>&1
EOF

# log rotation
cat <<EOF > /etc/logrotate.d/hubot
/var/log/hubot.log {
  daily
  missingok
  rotate 14
  size 50M
  compress
  delaycompress
  notifempty
  create 640 hubot hubot
  sharedscripts
  postrotate
    restart hubot
  endscript
}
EOF

# start the bot
start hubot
