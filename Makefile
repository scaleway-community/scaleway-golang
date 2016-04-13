NAME =			golang
VERSION =		latest
VERSION_ALIASES =	1.6.1
TITLE =			Golang
DESCRIPTION =		Golang
SOURCE_URL =		https://github.com/scaleway-community/scaleway-golang
VENDOR_URL =		http://golang.org
DEFAULT_IMAGE_ARCH =	x86_64

IMAGE_VOLUME_SIZE =     50G
IMAGE_BOOTSCRIPT =      stable
IMAGE_NAME =            Golang 1.6.1


## Image tools  (https://github.com/scaleway/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - https://j.mp/scw-builder | bash
-include docker-rules.mk
