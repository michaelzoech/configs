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
        openssh
        password-gorilla
        python
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
    local filename=$(basename $1)
    local sourcepath=$1
    local targetpath=$2

    if [ -f "$targetpath" ] || [ -d "$targetpath" ]; then
        [ "$(readlink "$targetpath")" = "$sourcepath" ] && return 0
        echo "Skipping '.$filename'. Already exists in home folder but is not a soft link!"
    else
        echo "Installing soft link for $filename"
        ln -s "$sourcepath" "$targetpath"
    fi
}

soft_link_files() {
    echo_step "Creating soft links"
    local scriptdir=$1
    local platform=$(if [[ "$(uname -o)" =~ Linux ]] ; then echo -n "arch" ; else echo -n "Darwin" ; fi)

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
        shrc
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
        local common_file="$scriptdir/$file"
        local platform_file="$scriptdir/$file.$platform"
        create_soft_link "$common_file" "$HOME/.$file"
        [[ -f "$platform_file" ]] && create_soft_link "$platform_file" "$HOME/.$file.platform"
    done
}

main() {
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    echo $DIR
    rm -rf ~/.bootstrap
    mkdir ~/.bootstrap
    pushd ~/.bootstrap > /dev/null

    if [[ ! -f "/etc/sudoers" ]] ; then
        echo "Cannot find '/etc/sudoers'!"
        echo "Install base-devel and allow user to become sudo root!"
        exit 1
    fi

    install_trizen
    install_common_arch_packages
    soft_link_files "$DIR"
    install_vim_dein

    popd > /dev/null
    rm -rf ~/.bootstrap
}

main

