#!/usr/bin/env python3

import os
import subprocess
import sys
import argparse
from enum import Enum, auto

PACKAGES = {
    "i3": {
        "shared": ["i3-gaps", "polybar", "dunst", "picom", "NetworkManager", "i3lock", "scrot"],
        "fedora": [],
        "debian": [],
        "arch": [],
    },
    "sway": {
        "shared": ["sway", "waybar", "NetworkManager"],
        "fedora": ["mako"],
        "debian": ["mako-notifier"],
        "arch": ["mako"],
    }
}

class Distro(Enum):
    DEBIAN_BASED = auto()
    FEDORA_REDHAT_BASED = auto()
    ARCH_BASED = auto()
    UNSUPPORTED = auto()

def get_distro_info() -> Distro:
    with open("/etc/os-release", "r") as f:
        lines = f.readlines()
    info = {}
    for line in lines:
        key, _, value = line.partition('=')
        info[key] = value.strip().strip('"')
    
    distro = info.get("ID", "")
    distro_like = info.get("ID_LIKE", "")

    if distro in ["debian", "ubuntu"] or distro_like in ["debian", "ubuntu"]:
        return Distro.DEBIAN_BASED
    elif distro in ["fedora", "redhat"] or distro_like in ["fedora", "redhat"]:
        return Distro.FEDORA_REDHAT_BASED
    elif distro == "arch" or distro_like == "arch":
        return Distro.ARCH_BASED
    else:
        return Distro.UNSUPPORTED

def install_packages(window_manager: str):
    distro_type = get_distro_info()

    if distro_type == Distro.DEBIAN_BASED:
        subprocess.run(["sudo", "apt-get", "install", "-y"] + PACKAGES[window_manager]["shared"] + PACKAGES[window_manager]["debian"])
    elif distro_type == Distro.FEDORA_REDHAT_BASED:
        subprocess.run(["sudo", "dnf", "install", "-y"] + PACKAGES[window_manager]["shared"] + PACKAGES[window_manager]["fedora"])
    elif distro_type == Distro.ARCH_BASED:
        subprocess.run(["sudo", "pacman", "-Suy"] + PACKAGES[window_manager]["shared"] + PACKAGES[window_manager]["arch"])
    else:
        print(f"Unsupported distribution.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Install either sway or i3 based on the distribution.")
    parser.add_argument("window_manager", choices=["sway", "i3"], help="Choose the window manager to install.")
    args = parser.parse_args()

    install_packages(args.window_manager)

