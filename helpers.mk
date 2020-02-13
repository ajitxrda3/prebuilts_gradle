
GRADLE_VERSION := 5.6.2
GRADLE_PATH := $(HOST_OUT)/gradle-$(GRADLE_VERSION)/bin/gradle

GRADLE_GLOBAL_BUILD_PATH = $(abspath $(PRODUCT_OUT)/obj/APPS)
GRADLE_HOME_PATH = $(abspath $(PRODUCT_OUT)/.gradle)

define gradle_build

JAVA_SRCS := $(call all-java-files-under, $(2))
XML_SRCS : $(shell find $(2) -type f -name *.xml)

$(1): $(JAVA_SRCS) $(XML_SRCS)
	mkdir -p $(GRADLE_GLOBAL_BUILD_PATH)
	echo "sdk.dir = $(ANDROID_SDK_ROOT)" > $(2)/local.properties
	GRADLE_GLOBAL_BUILD_PATH=$(GRADLE_GLOBAL_BUILD_PATH) \
		$(GRADLE_PATH) -g $(GRADLE_HOME_PATH) --no-daemon -p $(2) $(3)

endef
