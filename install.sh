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

echo "Creating backup dir ${backup_dir}"
mkdir "${backup_dir}" || exit 1
install .bash_profile
install .bashrc
install .dircolors
install .git-prompt.bsh
install .gitconfig
install .gitignore
install .tmux.conf
install .vimrc
install .zshrc
