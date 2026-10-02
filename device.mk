# SPDX-License-Identifier: Apache-2.0
DEVICE_PATH := device/oneplus/astonc
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)
$(call inherit-product, vendor/twrp/config/common.mk)

PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)
# Stock vendor first API and SDK are 33; the port's product API is not the BSP API.
PRODUCT_SHIPPING_API_LEVEL := 33
PRODUCT_TARGET_VNDK_VERSION := 33

# Build only the separate recovery; preserve the installed boot chain.
PRODUCT_BUILD_RECOVERY_IMAGE := true
PRODUCT_BUILD_BOOT_IMAGE := false
PRODUCT_BUILD_INIT_BOOT_IMAGE := false
PRODUCT_BUILD_VENDOR_BOOT_IMAGE := false
PRODUCT_BUILD_SYSTEM_IMAGE := false
PRODUCT_BUILD_VENDOR_IMAGE := false
PRODUCT_BUILD_ODM_IMAGE := false
PRODUCT_BUILD_PRODUCT_IMAGE := false
PRODUCT_BUILD_SYSTEM_EXT_IMAGE := false
PRODUCT_BUILD_SYSTEM_DLKM_IMAGE := false
PRODUCT_BUILD_VENDOR_DLKM_IMAGE := false
PRODUCT_BUILD_USERDATA_IMAGE := false
PRODUCT_BUILD_CACHE_IMAGE := false
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_VIRTUAL_AB_OTA := true
PRODUCT_BUILD_VBMETA_IMAGE := false

PRODUCT_PACKAGES += android.hardware.boot-service.default_recovery
PRODUCT_PACKAGES += astonc_service.recovery astonc_lshal.recovery astonc_blkid.recovery
PRODUCT_PACKAGES += astonc_keymint_v2_compat.recovery astonc_libxml2.recovery

# Recovery subset of AOSP base_vendor.mk; no full Android vendor product.
PRODUCT_PACKAGES += \
    adbd.recovery \
    cgroups.recovery.json \
    init_second_stage.recovery \
    ld.config.recovery.txt \
    linker.recovery \
    otacerts.recovery \
    recovery \
    shell_and_utilities_recovery \
    task_profiles.json.recovery \
    watchdogd.recovery
PRODUCT_VENDOR_PROPERTIES += \
    ro.recovery.usb.vid=18D1 \
    ro.recovery.usb.adb.pid=D001 \
    ro.recovery.usb.fastboot.pid=4EE0

# Current vendor/build.prop and normal Android agree; use the target TEE path.
# Source hashes and the target disabled/property trigger are inventoried.
PRODUCT_VENDOR_PROPERTIES += \
    vendor.gatekeeper.disable_spu=true \
    vendor.gatekeeper.is_security_level_spu=0

# logd needs task_profiles.json.recovery even when crypto is disabled. The
# upstream recovery required-list only selects that module with include_crypto.
