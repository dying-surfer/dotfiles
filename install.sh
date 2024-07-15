#!/bin/bash

dotfiles_dir=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
backup_dir="${HOME}/dotfilesbackup_"$(date +%Y%m%d_%H%M%S)

# Installs a file (backup and copy from dotfiles/custom or dotfiles)
function install(){
    file="$1";
    
    echo "Backing up $file"
    # Backup existing
    mv "${HOME}/${file}" "$backup_dir/" > /dev/null 2>&1
    
    # Override with repository version, or custom if exists
    if [ -f "${dotfiles_dir}/custom/${file}" ]; then
        full_path="${dotfiles_dir}/custom/${file}"
    else        
        full_path="${dotfiles_dir}/${file}"
    fi

    echo "Installing $file"
    ln -sf "${full_path}" "${HOME}/${file}"
}

# Installs a dir (backup & copy)
function installdir(){
    dir="$1";

    echo "Backing up $dir"
    # Backup existing
    mv "${HOME}/${dir}" "$backup_dir/" > /dev/null 2>&1

    echo "Installing $dir"
    cp -rs "${dotfiles_dir}/${dir}" "${HOME}/${dir}"
}

# Used for files that are meant to be overriden
function customcopy(){
    file="$1";

    if [[ ! -f "${dotfiles_dir}/custom/${file}" ]]; then
      cp "${dotfiles_dir}/.bashrc" "${dotfiles_dir}/custom/.bashrc"
    fi
}

echo "Creating backup dir ${backup_dir}"
mkdir "${backup_dir}" || exit 1

#.bashrc is meant to be overriden
mkdir "${dotfiles_dir}/custom" 2> /dev/null
customcopy .bashrc

installdir .bash-plugins
install .bash_profile
install .bashrc
install .dircolors
install .git-prompt.bsh
install .gitconfig
install .gitignore
install .tmux.conf
install .vimrc
install .zshrc
