#!/usr/bin/env bash

set -e

echo_step() {
	printf "\n%s\n\n" "$@"
}

install_common_arch_packages() {
	echo_step "Installing common packages"
	local packages=(
		alsa-utils
		bc
		bind-tools
		google-chrome
		conky
		dstat
		feh
		gimp
		git
		gksu
		inkscape
		mplayer
		mupdf
		net-tools
		nvidia
		obs-studio
		openssh
		password-gorilla
		ruby
		rxvt-unicode
		strace
		sysstat
		tig
		thunar
		trayer
		tree
		unzip
		vim
		vlc
		xmonad
		xmonad-contrib
		xterm
		zeal
		zsh
	)
	trizen -S --needed ${packages[@]}
}

install_trizen() {
	$(which apacman > /dev/null) && return 0 || :
	echo_step "Installing apacman"
	git clone https://aur.archlinux.org/trizen.git
	pushd trizen > /dev/null
	makepkg -si --noconfirm
	popd > /dev/null
}

install_vim_dein() {
	[ -d "${HOME}/.dein" ] && return 0 || :
	echo_step "Installing vim plugin manager 'dein'"
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
	sh ./installer.sh ${HOME}/.dein
}

create_soft_link() {
	local scriptdir=$1
	local filename=$2

	local sourcepath="${scriptdir}/${filename}"
	local targetpath="${HOME}/.${filename}"

	if [ -f "$targetpath" ] || [ -d "$targetpath" ]; then
		[ "$(readlink "$targetpath")" = "$sourcepath" ] && return 0
		echo "Error .$filename already exists in home folder but is not a soft link"
		exit 1
	fi

	echo "Installing soft link for $filename"

	ln -s "$sourcepath" "$targetpath"
}

soft_link_files() {
	echo_step "Creating soft links"
	local scriptdir=$1

	local files=(
		apvlvrc
		asoundrc
		bashrc
		bash_profile
		conkyrc
		git.scmbrc
		oh-my-zsh
		profile
		scmbrc
		scm_breeze
		vim
		vimrc
		XCompose
		Xdefaults
		xinitrc
		Xmodmap
		xmonad
		zprofile
		zsh_custom
		zshrc
	)

	for file in "${files[@]}"
	do
		create_soft_link "$scriptdir" $file
	done
}

main() {
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	echo $DIR
	rm -rf ~/.bootstrap
	mkdir ~/.bootstrap
	pushd ~/.bootstrap > /dev/null

	echo "Installing base packages"
	echo "You should have installed base-devel and put the user into sudoers group"

	install_trizen
	install_common_arch_packages
	soft_link_files "$DIR"
	install_vim_dein

	popd > /dev/null
	rm -rf ~/.bootstrap
}

main

