#!/usr/bin/env bash

xrandr --output HDMI-2 --mode 1920x1080 --primary
xrandr --output HDMI-1 --mode 1920x1080 --right-of HDMI-2

