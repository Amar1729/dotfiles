#!/bin/bash

# requires running as root!

sleep 10

DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/$DISPLAY xwd -root > /tmp/greeter.xwd

convert /tmp/greeter.xwd /tmp/greeter.jpg
