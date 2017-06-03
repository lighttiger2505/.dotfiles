ROOT_PATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

all:

# Setup env setting
init:
	@DOTPATH=$(ROOT_PATH) bash $(ROOT_PATH)/bin/init.sh

link:
	@DOTPATH=$(ROOT_PATH) bash $(ROOT_PATH)/bin/link.sh
