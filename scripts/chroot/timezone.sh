#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Lima /etc/localtime
hwclock --systohc
