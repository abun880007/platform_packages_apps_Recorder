#
# Copyright (C) 2017-2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#	  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_RESOURCE_DIR := $(LOCAL_PATH)/app/src/main/res

LOCAL_MANIFEST_FILE := app/src/main/AndroidManifest.xml

LOCAL_SRC_FILES := \
	$(call all-java-files-under, app/src/main/java)


LOCAL_USE_AAPT2 := true

LOCAL_STATIC_ANDROID_LIBRARIES += \
	androidx.annotation_annotation \
	androidx-constraintlayout_constraintlayout \
	androidx-constraintlayout_constraintlayout-solver \
	androidx.appcompat_appcompat \
	androidx.cardview_cardview \
	androidx.recyclerview_recyclerview \
	com.google.android.material_material \

LOCAL_PACKAGE_NAME := Recorder
LOCAL_CERTIFICATE := platform
LOCAL_PRIVILEGED_MODULE := true
#LOCAL_PROGUARD_FLAG_FILES := $(LOCAL_PATH)/../../proguard-rules.pro

LOCAL_PRIVATE_PLATFORM_APIS := true

include $(BUILD_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := RecorderStudio
LOCAL_MODULE_CLASS := FAKE
LOCAL_MODULE_SUFFIX := -timestamp
recorder_system_deps := $(call java-lib-deps,framework)
recorder_system_libs_path := $(abspath $(LOCAL_PATH))/system_libs

include $(BUILD_SYSTEM)/base_rules.mk

.PHONY: copy_recorder_system_deps
copy_recorder_system_deps: $(recorder_system_deps)
	$(hide) mkdir -p $(recorder_system_libs_path)
	$(hide) rm -rf $(recorder_system_libs_path)/*.jar
	$(hide) cp $(recorder_system_deps) $(recorder_system_libs_path)/framework.jar

$(LOCAL_BUILT_MODULE): copy_recorder_system_deps
	$(hide) echo "Fake: $@"
	$(hide) mkdir -p $(dir $@)
	$(hide) touch $@
