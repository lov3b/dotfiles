#!/usr/bin/env python3

import os
import subprocess
import argparse
from enum import Enum, auto
from typing import Optional

PACKAGES = {
    "i3": {
        "shared": [
            "i3-gaps",
            "polybar",
            "dunst",
            "picom",
            "NetworkManager",
            "i3lock",
            "scrot",
            "flameshot",
        ],
        "fedora": [],
        "debian": [],
        "arch": [],
    },
    "sway": {
        "shared": ["sway", "waybar", "NetworkManager"],
        "fedora": ["mako"],
        "debian": ["mako-notifier"],
        "arch": ["mako"],
    },
    "build": {
        "shared": ["git", "curl", "neovim"],
        "fedora": [],
        "debian": ["build-essential"],
        "arch": ["base-devel"],
    },
}


class Distro(Enum):
    DEBIAN_BASED = auto()
    FEDORA_REDHAT_BASED = auto()
    ARCH_BASED = auto()
    UNSUPPORTED = auto()


cached_distro_info: Optional[Distro] = None


def get_distro_info() -> Distro:
    global cached_distro_info

    if cached_distro_info is not None:
        return cached_distro_info

    with open("/etc/os-release", "r") as f:
        lines = f.readlines()
    info = {}
    for line in lines:
        key, _, value = line.partition("=")
        info[key] = value.strip().strip('"')

    distro = info.get("ID", "")
    distro_like = info.get("ID_LIKE", "")

    if distro in ["debian", "ubuntu"] or distro_like in ["debian", "ubuntu"]:
        cached_distro_info = Distro.DEBIAN_BASED
    elif distro in ["fedora", "redhat"] or distro_like in ["fedora", "redhat"]:
        cached_distro_info = Distro.FEDORA_REDHAT_BASED
    elif distro == "arch" or distro_like == "arch":
        cached_distro_info = Distro.ARCH_BASED
    else:
        cached_distro_info = Distro.UNSUPPORTED

    return cached_distro_info


def install_window_manager(window_manager: str):
    match get_distro_info():
        case Distro.DEBIAN_BASED:
            subprocess.run(
                ["sudo", "apt-get", "install", "-y"]
                + PACKAGES[window_manager]["shared"]
                + PACKAGES[window_manager]["debian"]
            )
        case Distro.FEDORA_REDHAT_BASED:
            subprocess.run(
                ["sudo", "dnf", "install", "-y"]
                + PACKAGES[window_manager]["shared"]
                + PACKAGES[window_manager]["fedora"]
            )
        case Distro.ARCH_BASED:
            subprocess.run(
                ["sudo", "pacman", "-Suy"]
                + PACKAGES[window_manager]["shared"]
                + PACKAGES[window_manager]["arch"]
            )
        case Distro.UNSUPPORTED:
            print(f"Unsupported distribution.")


def install_buildtools():
    match get_distro_info():
        case Distro.DEBIAN_BASED:
            subprocess.run(
                ["sudo", "apt-get", "install", "-y"]
                + PACKAGES["build"]["shared"]
                + PACKAGES["build"]["debian"]
            )
            pass
        case Distro.FEDORA_REDHAT_BASED:
            subprocess.run(
                [
                    "sudo",
                    "dnf",
                    "group" "install",
                    "-y",
                    "C Development Tools and Libraries",
                    "Development Tools",
                ]
            )
            subprocess.run(
                [
                    "sudo",
                    "dnf",
                    "install",
                    "-y",
                ]
                + PACKAGES["build"]["shared"]
                + PACKAGES["build"]["fedora"],
            )
        case Distro.ARCH_BASED:
            subprocess.run(
                ["sudo", "pacman", "-Syu"]
                + PACKAGES["build"]["shared"]
                + PACKAGES["build"]["arch"]
            )
        case Distro.UNSUPPORTED:
            pass


def install_paru():
    os.chdir("/tmp")
    subprocess.run(["git", "clone", "https://aur.archlinux.org/paru-bin.git"])
    os.chdir("paru-bin")
    yes = subprocess.Popen("yes", stdout=subprocess.PIPE)
    makepkg = subprocess.Popen(["makepkg", "--syncdeps", "--install"], stdin=yes.stdout)
    makepkg.communicate()
    yes.terminate()
    yes.wait()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Install presets of packages for selected programs"
        "under the three Linux bases (Fedora, Debian & Arch)"
    )
    parser.add_argument(
        "programs",
        nargs="+",
        choices=[*PACKAGES.keys(), "paru"],
        help="Choose the presets to install.",
    )
    args, distro_info = parser.parse_args(), get_distro_info()

    if "build" in args.programs or (
        "paru" in args.programs and distro_info == Distro.ARCH_BASED
    ):
        install_buildtools()

    if "paru" in args.programs and distro_info == Distro.ARCH_BASED:
        install_paru()

    if "i3" in args.programs:
        install_window_manager("i3")

    if "sway" in args.programs:
        install_window_manager("sway")
