#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# Also explicitly sourced by the host build wrapper before envsetup/lunch.
export FOX_BUILD_DEVICE=astonc
export FOX_BUILD_TYPE=Unofficial
export FOX_MAINTAINER_PATCH_VERSION=1
export FOX_VANILLA_BUILD=1
export FOX_AB_DEVICE=1
export OF_AB_DEVICE_WITH_RECOVERY_PARTITION=1
export OF_NO_REFLASH_CURRENT_ORANGEFOX=1
export OF_NO_SPLASH_CHANGE=1
export FOX_DISABLE_UPDATEZIP=1
export FOX_DELETE_MAGISK_ADDON=1
export FOX_DELETE_AROMAFM=1
export OF_ADVANCED_SECURITY=1
export OF_SCREEN_H=2780
export FOX_USE_MISANS_FONTS=1
export FOX_USE_NANO_EDITOR=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_SED_BINARY=1
# Keep runtime tools in the ramdisk, not in encrypted /sdcard/Fox.
export FOX_CUSTOM_BINS_TO_SDCARD=0
