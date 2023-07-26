#/usr/bin/env bash

export __GL_GSYNC_ALLOWED=0
export __GL_VRR_ALLOWED=0
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export WLR_DRM_NO_ATOMIC=1
export WLR_NO_HARDWARE_CURSORS=1
# export WLR_RENDERER=vulkan
export XWAYLAND_NO_GLAMOR=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export GDK_BACKEND=wayland
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway
export GBM_BACKEND=nvidia-drm
export MOZ_ENABLE_WAYLAND=1

sway --unsupported-gpu
