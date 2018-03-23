.PHONY: install release-build package
VERSION = 0.0.0
PLATFORM = linux
CERTNAME = ""
BUNDLE_ID = org.whalebird.social

ICON = ""
CERT = ""
ifeq ($(PLATFORM), darwin)
	ICON = --icon=./build/icons/whalebird.icns
	CERT = --sign='$(CERTNAME)'
endif
ifeq ($(PLATFORM), windows)
	ICON = --icon=./build/icons/whalebird.ico
endif
ifeq ($(PLATFORM),mas)
	ICON = --icon=./build/icons/whalebird.icns
endif

BASE_PACKAGE_CMD = electron-packager ./ whalebird --platform=$(PLATFORM) --arch=x64 --electron-version=1.8.3  --build-version=$(VERSION) --asar --out=packages --ignore="^/src" --ignore="^/test" --ignore="^/.electron-vue" --ignore="^/.envrc" --prune=true $(ICON) $(CERT) --overwrite
PACKAGE_CMD = $(BASE_PACKAGE_CMD)

ifeq ($(PLATFORM),mas)
	PACKAGE_CMD = $(BASE_PACKAGE_CMD) --app-bundle-id=$(BUNDLE_ID) --app-version=$(VERSION)
endif



all: install release-build package
install: package.json
	npm install
release-build: package.json
	npm run pack
package: release-build
	$(PACKAGE_CMD)
store: package
	codesign --deep --verbose --force --sign '$(CERTNAME)' ./packages/whalebird-mas-x64/whalebird.app
	codesign --verify -vvvv ./packages/whalebird-mas-x64/whalebird.app
