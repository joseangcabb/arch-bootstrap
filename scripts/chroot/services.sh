#!/bin/bash

pacman -S networkmanager --noconfirm
systemctl enable NetworkManager
