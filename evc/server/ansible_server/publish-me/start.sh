#!/bin/sh

# DBus 서비스 시작
dbus-daemon --system

# Avahi 데몬 시작
avahi-daemon -D

# Avahi 서비스 등록
avahi-publish -s 'evc_edge' _workstation._tcp 9

# 대몬이 종료되지 않도록 대기
tail -f /dev/null