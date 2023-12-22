
GRADLE_VERSION := 8.5
GRADLE_PATH := $(HOST_OUT)/gradle-$(GRADLE_VERSION)/bin/gradle

GRADLE_GLOBAL_BUILD_PATH = $(abspath $(PRODUCT_OUT)/obj/APPS)
GRADLE_HOME_PATH = $(abspath $(PRODUCT_OUT)/.gradle)
GRADLE_JAVA_HOME = $(abspath $(TOP)/prebuilts/jdk/jdk21/linux-x86/)

define gradle_build

$(1): | gradle-prebuilt
	mkdir -p $(GRADLE_GLOBAL_BUILD_PATH)
	grep -qF 'sdk.dir' $(2)/local.properties || echo "sdk.dir = $(ANDROID_SDK_ROOT)" >> $(2)/local.properties
	GRADLE_GLOBAL_BUILD_PATH=$(GRADLE_GLOBAL_BUILD_PATH) JAVA_HOME=$(GRADLE_JAVA_HOME) \
		$(GRADLE_PATH) -g $(GRADLE_HOME_PATH) --stacktrace --no-daemon -p $(2) $(3)

endef
