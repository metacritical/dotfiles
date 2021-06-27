#!/bin/bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

DOTFILES=(".doom.d" ".zshrc")

echo "Dotfiles in '$DOTFILES_DIR'"

for DOTFILE in "${DOTFILES[@]}"; do
    echo "Installing symlink for ~/$DOTFILE'"

    if [ -e "$HOME/$DOTFILE" ] ;
    then
        if [ -L "$HOME/$DOTFILE" ] ; # Is a symlink
        then
            BACKUPEXT="symlink_backup"
            DELETE_CMD="rm"
        else
            BACKUPEXT="backup"
            DELETE_CMD="rm -r"
        fi

        echo "-> The ~/$DOTFILE exists, creating backup to ~/$DOTFILE.$BACKUPEXT"       
	cp "$HOME/$DOTFILE" "$HOME/$DOTFILE.$BACKUPEXT" && $($DELETE_CMD "$HOME/$DOTFILE")
    fi

    cp -r "$DOTFILES_DIR/dot$DOTFILE" "$HOME/$DOTFILE"
done

echo "Dotfiles installed successfuly!"