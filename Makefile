CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitmodules .config
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
CONFIGDIRS := $(wildcard ./.config/*)

all:

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)
	@$(foreach val, $(CONFIGDIRS), /bin/ls -dF $(val);)

deploy:
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@$(foreach val, $(CONFIGDIRS), ln -sfnv $(abspath $(val)) $(HOME)/.config/$(notdir $(val));)
