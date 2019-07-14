@@KILL_PROCS@@
include @@THEOS@@/makefiles/common.mk

FRAMEWORK_NAME = @@PROJECTNAME@@Substrate

$(FRAMEWORK_NAME)_FILES = $(wildcard Sources/**/*.x) $(wildcard Sources/**/*.xm)
$(FRAMEWORK_NAME)_EXTRA_FRAMEWORKS = CydiaSubstrate Cephei @@PROJECTNAME@@
$(FRAMEWORK_NAME)_INSTALL_PATH = /Library/Frameworks
$(FRAMEWORK_NAME)_CFLAGS = -IResources/Headers -fobjc-arc
$(FRAMEWORK_NAME)_LDFLAGS = -rpath /usr/lib/libswift/stable -rpath /Library/Frameworks/$(FRAMEWORK_NAME).framework/Frameworks -rpath /Library/Frameworks/$(FRAMEWORK_NAME).framework/Libraries

include $(THEOS_MAKE_PATH)/framework.mk

before-all::
	$(ECHO_NOTHING)DEBUG="$(DEBUG)" TARGET="$(TARGET)" ARCHS="$(ARCHS)" sh ../Scripts/build.sh$(ECHO_END)
	$(ECHO_NOTHING)rsync -raz ../Dependencies/**/*.framework $(THEOS_LIBRARY_PATH)/$(ECHO_END)

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/Frameworks/$(FRAMEWORK_NAME).framework/Frameworks/$(ECHO_END)
	$(ECHO_NOTHING)INSTALL_PATH="$(THEOS_STAGING_DIR)/Library/Frameworks/$(FRAMEWORK_NAME).framework/Frameworks" sh ../Scripts/copy_frameworks.sh$(ECHO_END)
	# Filter plist
	$(ECHO_NOTHING)if [ -f Supporting\ Files/Filter.plist ]; then mkdir -p $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries/; cp Supporting\ Files/Filter.plist $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries/$(FRAMEWORK_NAME).plist; fi$(ECHO_END)
	$(ECHO_NOTHING)ln -s /Library/Frameworks/$(FRAMEWORK_NAME).framework/$(FRAMEWORK_NAME) $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries/$(FRAMEWORK_NAME).dylib$(ECHO_END)
	# PreferenceLoader plist
	$(ECHO_NOTHING)if [ -f Supporting\ Files/Preferences.plist ]; then mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/$(FRAMEWORK_NAME)/; cp Supporting\ Files/Preferences.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/$(FRAMEWORK_NAME)/; fi$(ECHO_END)

after-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/var/stash/usrlib/ $(THEOS_STAGING_DIR)/usr/lib/$(ECHO_END)
	$(ECHO_NOTHING)rsync -raz $(THEOS_STAGING_DIR)/Library/Frameworks/$(FRAMEWORK_NAME).framework $(THEOS_STAGING_DIR)/var/stash/usrlib/ && rm -r $(THEOS_STAGING_DIR)/Library/Frameworks/$(FRAMEWORK_NAME).framework$(ECHO_END)
	$(ECHO_NOTHING)ln -s /var/stash/usrlib/$(FRAMEWORK_NAME).framework $(THEOS_STAGING_DIR)/usr/lib/$(ECHO_END)
	$(ECHO_NOTHING)ln -s /var/stash/usrlib/$(FRAMEWORK_NAME).framework $(THEOS_STAGING_DIR)/Library/Frameworks/$(ECHO_END)
