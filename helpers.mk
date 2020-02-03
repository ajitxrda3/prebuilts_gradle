
GRADLE_VERSION := 5.6.2
GRADLE_PATH := $(HOST_OUT)/gradle-$(GRADLE_VERSION)/bin/gradle

LOCAL_SRC_APK_PATH := app/outputs/apk/release/app-release-unsigned.apk
GRADLE_GLOBAL_BUILD_PATH = $(abspath $(PRODUCT_OUT)/obj/APPS)
GRADLE_HOME_PATH = $(abspath $(PRODUCT_OUT)/.gradle)

LOCAL_BUILD_PATH ?= $(GRADLE_GLOBAL_BUILD_PATH)/$(LOCAL_MODULE)

ANDROID_SDK_ROOT = $(abspath $(TOPDIR)prebuilts/sdk)

define gradle_build
$(1):
	mkdir -p $(GRADLE_GLOBAL_BUILD_PATH)
	echo "sdk.dir = $(ANDROID_SDK_ROOT)" > $(2)/local.properties
	GRADLE_GLOBAL_BUILD_PATH=$(GRADLE_GLOBAL_BUILD_PATH) \
		$(GRADLE_PATH) -g $(GRADLE_HOME_PATH) --no-daemon -p $(2) $(3)
	install $(LOCAL_BUILD_PATH)/$(LOCAL_SRC_APK_PATH) \
		$(PRODUCT_OUT)/prebuilt/$(LOCAL_MODULE).apk
endef
