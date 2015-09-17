NAME =			golang
VERSION =		latest
VERSION_ALIASES =	1.4.2 1.4 1
TITLE =			Golang
DESCRIPTION =		Golang
SOURCE_URL =		https://github.com/scaleway/image-app-golang
VENDOR_URL =		http://golang.org

IMAGE_VOLUME_SIZE =     50G
IMAGE_BOOTSCRIPT =      stable
IMAGE_NAME =            Golang


## Image tools  (https://github.com/scaleway/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - http://j.mp/scw-builder | bash
-include docker-rules.mk
