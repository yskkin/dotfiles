safe_source() {
    if [ -e $1 ]; then
        source $1
    fi
}

if ! command which -s brew; then
  echo "install Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

source $HOME/.zshrc.antigen
safe_source $HOME/.zshrc.private
safe_source `brew --prefix`/etc/profile.d/z.sh
safe_source $HOME/.homesick/repos/homeshick/homeshick.sh

if command which -s direnv; then
    eval "$(direnv hook zsh)"
fi

