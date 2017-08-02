ROOT_PATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

all:

# Setup env setting


install:
	@DOTPATH=$(ROOT_PATH) bash $(ROOT_PATH)/etc/install.sh

link:
	@DOTPATH=$(ROOT_PATH) bash $(ROOT_PATH)/etc/link.sh

init: install link
