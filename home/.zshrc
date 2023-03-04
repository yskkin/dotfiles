safe_source() {
    if [ -e $1 ]; then
        source $1
    fi
}

if ! which brew &> /dev/null; then
  echo "install Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! which sheldon &> /dev/null; then
  echo "install shelldon..."
  brew install sheldon
  yes | sheldon init
fi

safe_source $HOME/.zshrc.private
safe_source "$(brew --prefix)/etc/profile.d/z.sh"
safe_source "$(brew --prefix)/opt/homeshick/homeshick.sh"

if which direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi


if (! test -d ~/.emacs.d || git -C ~/.emacs.d status &> /dev/null); then
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

export ZSH="$HOME/.local/share/sheldon/repos/github.com/ohmyzsh/ohmyzsh"
plugins=(
  autojump
  brew
  bundler
  dircycle
  encode64
  gem
  git
  git-flow
  github
  macos
  npm
  perl
  pip
  python
  rails
  rbenv
  ruby
  urltools
)
ZSH_THEME="robbyrussell"
eval $(sheldon source)
