export PATH := binaries/.local/bin:$(PATH)

ifneq (,$(SUDO_USER))
	OWNER := $(SUDO_USER)
else
	OWNER := $(shell id -un)
endif

#Virtual profiles
install: system stow
uninstall: unstow

system: system-dependencies system-additional-packages
third-party: ~/bin/homestead

.PHONY: install uninstall stow unstow system system-dependencies system-additional-packages third-party test

~/bin:
	@mkdir $@
	@chown $(OWNER):$(OWNER) $@

~/bin/bash: ~/bin
	@mkdir $@
	@chown $(OWNER):$(OWNER) $@

~/bin/bash/%: ~/share/snippets/bash/%
	@ln -s $(abspath $<) $(abspath $@)

#APT related profiles
system-dependencies:
	@echo-warn "Installing minimal system dependencies..."
	@apt-install "java7-jdk php5-cli curl VirtualBox vagrant keepassx \
		cifs-utils gksu screen zsh ruby1.9.1-dev g++ libsqlite3-dev htop \
		terminator git lxc-docker docker-compose mysql-client imagemagick"
	@echo-success "Done!"

system-additional-packages:
	@echo-warn "Installing additionals system packages..."
	@apt-install "sparkleshare playonlinux git-cola chromium-browser ghex \
		gimp vlc nodejs npm flashplugin-nonfree zulucrypt-gui"
	@gem-install "git-up sass"
	@echo-success "Done!"

# Dotfiles (stowing) related profiles
stow:
	@stow-on "" 01
	@stow-on "Bash dotfiles" bash
	@stow-on "Session dotfiles" session
	@stow-on "Vim dotfiles" vim
	@stow-on "Git dotfiles" gitconfig
	@stow-on "Binaries" binaries
	@stow-on "Docker alias" docker-alias
	@stow-on "Shared files" share

unstow:
	@stow-off "Shared files" share
	@stow-off "Docker alias" docker-alias
	@stow-off "Binaries" binaries
	@stow-off "Git dotfiles" gitconfig
	@stow-off "Vim dotfiles" vim
	@stow-off "Session dotfiles" session
	@stow-off "Bash dotfiles" bash
	@stow-off "" 01

include-profile: stow
	$(shell grep "profile_customisation" ~/.profile | wc -l) || \
	$(shell echo ". ~/.profile_customisation" >> ~/.profile )

#Third party software related profiles

~/bin/composer: system-dependencies ~/bin
	@curl -sS https://getcomposer.org/installer | php -- --install-dir=/tmp
	@mv /tmp/composer.phar $@

~/bin/homestead: ~/bin/composer
	@vagrant box add --provider virtualbox laravel/homestead
	@~/bin/composer global require "laravel/homestead"
	@ln -s ~/.composer/vendor/bin/homestead $@
	@$@ init
