#
# Copyright (C) 2020 Bithium S.A.
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

LOCAL_PATH := $(call my-dir)

include $(LOCAL_PATH)/helpers.mk
include $(CLEAR_VARS)

LOCAL_MODULE := gradle-prebuilt
LOCAL_IS_HOST_MODULE := true
LOCAL_PREBUILT_MODULE_FILE := $(TOPDIR)tools/external/gradle/gradle-$(GRADLE_VERSION)-bin.zip

LOCAL_ADDITIONAL_DEPENDENCIES := $(PRODUCT_OUT)/.gradle/init.gradle \
	$(HOST_OUT)/gradle-$(GRADLE_VERSION)/bin/gradle

$(PRODUCT_OUT)/.gradle/init.gradle: $(LOCAL_PATH)/init.gradle
	install -d $(PRODUCT_OUT)/.gradle
	install $(TOP_DIR)prebuilts/gradle/init.gradle $(PRODUCT_OUT)/.gradle/init.gradle

$(HOST_OUT)/gradle-$(GRADLE_VERSION)/bin/gradle: $(LOCAL_PREBUILT_MODULE_FILE)
	unzip -f -u -DD $< -d $(HOST_OUT)

include $(BUILD_PHONY_PACKAGE)
