#!/bin/bash

/usr/bin/bwrap --dev-bind / / \
               --bind /opt/wechat-beta/crap/uos-release /etc/os-release \
               --bind /opt/wechat-beta/crap/uos-lsb /etc/lsb-release \
               --bind /opt/wechat-beta/crap/usr/lib/license/ /usr/lib/license \
               --bind /opt/wechat-beta/crap/var/ /var \
               /opt/wechat-beta/wechat
