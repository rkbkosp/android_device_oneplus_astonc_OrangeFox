# SPDX-License-Identifier: Apache-2.0
LOCAL_PATH := $(call my-dir)

# QSEE's vendor consumer uses the supported AOSP vendor libxml2 variant.
# That implementation does not pull the framework ICU/APEX dependency.
include $(CLEAR_VARS)
LOCAL_MODULE := astonc_libxml2.recovery
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_STEM := libxml2
LOCAL_MULTILIB := 64
LOCAL_RECOVERY_MODULE := true
LOCAL_PREBUILT_MODULE_FILE := $(TARGET_OUT_VENDOR_SHARED_LIBRARIES)/libxml2.so
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
LOCAL_REQUIRED_MODULES := libxml2.vendor
LOCAL_NOTICE_FILE := external/libxml2/Copyright
include $(BUILD_PREBUILT)

# Keep the target vendor's legacy ABI provider separate from the automatically
# installed AOSP recovery KeyMint-V2 library. Vendor executables search it first.
include $(CLEAR_VARS)
LOCAL_MODULE := astonc_keymint_v2_compat.recovery
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_STEM := android.hardware.security.keymint-V2-ndk
LOCAL_MULTILIB := 64
LOCAL_RECOVERY_MODULE := true
LOCAL_PREBUILT_MODULE_FILE := $(TARGET_OUT_SHARED_LIBRARIES)/astonc-compat/android.hardware.security.keymint-V2-ndk.so
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
LOCAL_REQUIRED_MODULES := libastonc_keymint_v2_compat
LOCAL_SHARED_LIBRARIES := android.hardware.security.secureclock-V1-ndk libbinder_ndk libc++ liblog
LOCAL_NOTICE_FILE := hardware/interfaces/NOTICE
include $(BUILD_PREBUILT)
