
GRADLE_VERSION := 5.6.4
GRADLE_PATH := $(HOST_OUT)/gradle-$(GRADLE_VERSION)/bin/gradle

GRADLE_GLOBAL_BUILD_PATH = $(abspath $(PRODUCT_OUT)/obj/APPS)
GRADLE_HOME_PATH = $(abspath $(PRODUCT_OUT)/.gradle)

define gradle_build

$(1):
	mkdir -p $(GRADLE_GLOBAL_BUILD_PATH)
	echo "sdk.dir = $(ANDROID_SDK_ROOT)" > $(2)/local.properties
	GRADLE_GLOBAL_BUILD_PATH=$(GRADLE_GLOBAL_BUILD_PATH) \
		$(GRADLE_PATH) -g $(GRADLE_HOME_PATH) --no-daemon -p $(2) $(3)

endef
