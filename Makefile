ROOT_PATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

all:

# Setup env setting


install:
	@DOTPATH=$(ROOT_PATH) bash $(ROOT_PATH)/bin/install.sh

link:
	@DOTPATH=$(ROOT_PATH) bash $(ROOT_PATH)/bin/link.sh

init: install link
