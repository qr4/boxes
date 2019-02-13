#!/bin/sh
pacman -Syu --noconfirm $(cat /tmp/packages.arch)
