LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_STATIC_JAVA_LIBRARIES := \
    android-support-v13        \
    android-support-v4         \
    glide                      \
    xmp_toolkit                \
    zxing-core

LOCAL_SRC_FILES := \
    $(call all-java-files-under, src) \
    $(call all-java-files-under, src_pd) \
    $(call all-java-files-under, src_pd_gcam) \
    $(call all-renderscript-files-under, rs) \
    $(call all-java-files-under, quickReader/src) \

LOCAL_RESOURCE_DIR := \
    $(LOCAL_PATH)/res \
    $(LOCAL_PATH)/quickReader/res

LOCAL_STATIC_JAVA_AAR_LIBRARIES += \
    qreader-core \
    qreader-zxing

include $(LOCAL_PATH)/version.mk
LOCAL_AAPT_FLAGS := \
    --auto-add-overlay \
    --version-name "$(version_name_package)" \
    --version-code $(version_code_package) \
    --extra-packages me.dm7.barcodescanner.core \
    --extra-packages me.dm7.barcodescanner.zxing

LOCAL_PACKAGE_NAME := Snap
LOCAL_PRIVILEGED_MODULE := true

LOCAL_AAPT_FLAGS += --rename-manifest-package org.cyanogenmod.snap

#LOCAL_SDK_VERSION := current
LOCAL_RENDERSCRIPT_TARGET_API := 23

LOCAL_OVERRIDES_PACKAGES := Camera2

LOCAL_PROGUARD_FLAG_FILES := proguard.flags

LOCAL_JAVA_LIBRARIES := \
    org.slim.framework

# If this is an unbundled build (to install separately) then include
# the libraries in the APK, otherwise just put them in /system/lib and
# leave them out of the APK
ifneq (,$(TARGET_BUILD_APPS))
  LOCAL_JNI_SHARED_LIBRARIES := libjni_snapmosaic libjni_snaptinyplanet libjni_snapimageutil
else
  LOCAL_REQUIRED_MODULES := libjni_snapmosaic libjni_snaptinyplanet libjni_snapimageutil
endif

include $(BUILD_PACKAGE)

include $(CLEAR_VARS)

LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES += \
    qreader-core:quickReader/libs/core-1.9.3.aar \
    qreader-zxing:quickReader/libs/zxing-1.9.3.aar \
    zxing-core:quickReader/libs/zxing-core-g-2.3.1.jar

include $(BUILD_MULTI_PREBUILT)

include $(call all-makefiles-under, $(LOCAL_PATH))
