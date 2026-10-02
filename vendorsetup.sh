#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# Also explicitly sourced by the host build wrapper before envsetup/lunch.
export FOX_BUILD_DEVICE=astonc
export FOX_BUILD_TYPE=Unofficial
export FOX_MAINTAINER_PATCH_VERSION=1
export FOX_VANILLA_BUILD=1
export FOX_AB_DEVICE=1
export FOX_VIRTUAL_AB_DEVICE=1
export OF_AB_DEVICE_WITH_RECOVERY_PARTITION=1
export OF_NO_REFLASH_CURRENT_ORANGEFOX=1
export OF_NO_SPLASH_CHANGE=1
export FOX_DISABLE_UPDATEZIP=1
export FOX_DELETE_MAGISK_ADDON=1
export FOX_DELETE_AROMAFM=1
export OF_ADVANCED_SECURITY=1
export OF_SCREEN_H=2780
# Actual hole y=40..112, center=76. Runtime scale is x=1264/1080, y=1.
# Center the 56px status line at y=76; leave 40px below the hole for chrome.
export OF_STATUS_H=152
# Fox's right anchor is 1060, already 20 logical px inside a 1080px theme.
# 60 on the left and 20+40 on the right give equal ~70px native margins.
export OF_STATUS_INDENT_LEFT=60
export OF_STATUS_INDENT_RIGHT=40
# Beijing, UTC+8. POSIX TZ uses the opposite sign; saved user settings win.
export OF_DEFAULT_TIMEZONE="CST-8"
export FOX_USE_MISANS_FONTS=1
export FOX_USE_NANO_EDITOR=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_SED_BINARY=1
# Keep runtime tools in the ramdisk, not in encrypted /sdcard/Fox.
export FOX_CUSTOM_BINS_TO_SDCARD=0
