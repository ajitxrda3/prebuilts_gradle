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

LOCAL_PACKAGE_URL := https://services.gradle.org/distributions
LOCAL_MODULE_ARCHIVE := $(OUT_DIR)/gradle-$(GRADLE_VERSION)-bin.zip
LOCAL_MODULE_CONFIG := $(PRODUCT_OUT)/.gradle/init.gradle

LOCAL_ADDITIONAL_DEPENDENCIES = $(GRADLE_PATH) $(LOCAL_MODULE_CONFIG)

$(LOCAL_MODULE_CONFIG): $(LOCAL_PATH)/init.gradle
	install -d $(PRODUCT_OUT)/.gradle
	install $^ $@

$(GRADLE_PATH): $(LOCAL_MODULE_ARCHIVE)
	unzip -DD -u -o $< -d $(HOST_OUT)
	touch $@

$(LOCAL_MODULE_ARCHIVE):
	wget '$(LOCAL_PACKAGE_URL)/gradle-$(GRADLE_VERSION)-bin.zip' -O '$@'
	touch $@

include $(BUILD_PHONY_PACKAGE)

$(LOCAL_MODULE): $(GRADLE_PATH)
