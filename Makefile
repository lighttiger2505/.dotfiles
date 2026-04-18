CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitmodules .config .claude-private .claude-work
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
	ln -sfnv $(abspath scripts) $(HOME)/scripts

deploy-work:
	ln -sfnv $(abspath .claude-work) $(HOME)/.claude

deploy-private:
	@mkdir -p $(HOME)/.claude
	@$(foreach val, $(wildcard .claude-private/* .claude-private/.*), \
		$(if $(filter-out . .., $(notdir $(val))), \
			ln -sfnv $(abspath $(val)) $(HOME)/.claude/$(notdir $(val));))

linkdropbox:
	ln -s ~/Library/CloudStorage/Dropbox/vaults ~/vaults
	mkdir -p ~/.config
	ln -s ~/Library/CloudStorage/Dropbox/vimmemo ~/.config/vimmemo
	mkdir -p ~/.config/liary
	ln -s ~/Library/CloudStorage/Dropbox/liary/_post ~/.config/liary/_post
