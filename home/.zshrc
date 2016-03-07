safe_source() {
    if [ -e $1 ]; then
        source $1
    fi
}

source $HOME/.zshrc.antigen
safe_source $HOME/.zshrc.private
safe_source `brew --prefix`/etc/profile.d/z.sh
safe_source $HOME/.homesick/repos/homeshick/homeshick.sh

if $(which direnv > /dev/null); then
    eval "$(direnv hook zsh)"
fi

