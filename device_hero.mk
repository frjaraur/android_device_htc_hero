#
# Copyright (C) 2008 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PACKAGE_OVERLAYS := device/htc/hero/overlay

PRODUCT_PACKAGES += \
    librs_jni \
    sensors.hero \
    lights.hero 

# Passion uses high-density artwork where available
PRODUCT_LOCALES += mdpi

# proprietary side of the device
$(call inherit-product-if-exists, vendor/htc/hero/device_hero-vendor.mk)

# from device_dream_sapphire.mk
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml

PRODUCT_PROPERTY_OVERRIDES := \
    ro.media.dec.jpeg.memcap=10000000

PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/system/lib/libhtc_ril.so \
    ro.ril.hsxpa=2 \
    ro.ril.gprsclass=10 \
    wifi.interface=tiwlan0

# Time between scans in seconds. Keep it high to minimize battery drain.
# This only affects the case in which there are remembered access points,
# but none are in range.
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.supplicant_scan_interval=60

# density in DPI of the LCD of this board. This is used to scale the UI
# appropriately. If this property is not defined, the default value is 160 dpi. 
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=140

# Default network type
# 0 => WCDMA Preferred.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_network=0

# media configuration xml file
PRODUCT_COPY_FILES += \
    device/htc/hero/media_profiles.xml:/system/etc/media_profiles.xml

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/htc/hero/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

PRODUCT_COPY_FILES += \
    device/htc/hero/modules/rpcsec_gss_krb5.ko:system/lib/modules/2.6.29-cyanogenmod/kernel/net/sunrpc/auth_gss/rpcsec_gss_krb5.ko \
    device/htc/hero/modules/auth_rpcgss.ko:system/lib/modules/2.6.29-cyanogenmod/kernel/net/sunrpc/auth_gss/auth_rpcgss.ko \
    device/htc/hero/modules/sunrpc.ko:system/lib/modules/2.6.29-cyanogenmod/kernel/net/sunrpc/sunrpc.ko \
    device/htc/hero/modules/nfs.ko:system/lib/modules/2.6.29-cyanogenmod/kernel/fs/nfs/nfs.ko \
    device/htc/hero/modules/fuse.ko:system/lib/modules/2.6.29-cyanogenmod/kernel/fs/fuse/fuse.ko \
    device/htc/hero/modules/cifs.ko:system/lib/modules/2.6.29-cyanogenmod/kernel/fs/cifs/cifs.ko \
    device/htc/hero/modules/nfs_acl.ko:system/lib/modules/2.6.29-cyanogenmod/kernel/fs/nfs_common/nfs_acl.ko \
    device/htc/hero/modules/lockd.ko:system/lib/modules/2.6.29-cyanogenmod/kernel/fs/lockd/lockd.ko \
    device/htc/hero/modules/ramzswap.ko:system/lib/modules/ramzswap.ko

# stuff common to all HTC phones
$(call inherit-product, device/htc/common/common.mk)

$(call inherit-product, build/target/product/full.mk)

