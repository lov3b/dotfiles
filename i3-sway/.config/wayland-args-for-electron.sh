#!/bin/sh

# Check if the session is Wayland
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    echo "--enable-features=UseOzonePlatform --ozone-platform=wayland"
fi

