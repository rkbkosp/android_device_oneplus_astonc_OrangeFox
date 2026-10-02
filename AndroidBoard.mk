# SPDX-License-Identifier: Apache-2.0
LOCAL_PATH := $(call my-dir)

# BOARD_RECOVERY_IMAGE_PREPARE runs when the ramdisk timestamp is rebuilt.
# Track both host preparation inputs so incremental builds cannot reuse stale
# properties after the measured target configuration or helper changes.
$(call intermediates-dir-for,PACKAGING,recovery)/ramdisk_files-timestamp: \
    $(LOCAL_PATH)/scripts/prepare-crypto-properties.py \
    $(LOCAL_PATH)/config/crypto-version-inputs.json
