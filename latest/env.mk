IMAGE_NAME = golang
GOVER = $(shell curl --fail -s https://golang.org/VERSION?m=text | sed 's/go//' | cut -d'.' -f1-2)
BUILD_ARGS = GOVER=$(GOVER)
IMAGE_VERSION = stable-$(GOVER)
IMAGE_VERSION_ALIASES = $(GOVER) latest
IMAGE_TITLE = Golang $(GOVER)
IMAGE_DESCRIPTION = The Go Programming Language
IMAGE_SOURCE_URL = https://github.com/scaleway-community/scaleway-golang
IMAGE_VENDOR_URL = https://golang.org/
IMAGE_BOOTSCRIPT = mainline 4.4
