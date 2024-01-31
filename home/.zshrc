safe_source() {
    if [ -e $1 ]; then
        source $1
    fi
}

setup_ssh() {
  # https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent
  local keyfile=$HOME/.ssh/id_ed25519
  if [[ ! -f $keyfile ]]; then
    ssh-keygen -q -t ed25519 -N '' -f $keyfile -C "yskkin@gmail.com"
  fi
  if [[ -n $SSH_AGENT_PID ]]; then
    eval "$(ssh-agent -s)"
  fi

  if ! grep -q "github.com" ~/.ssh/config; then
    cat << EOF >> ~/.ssh/config
Host github.com
  AddKeysToAgent yes
  IdentityFile $keyfile
EOF
  fi
  # if ! (ssh-add -l | grep -q "yskkin@gmail.com"); then
  #   ssh-add $keyfile
  # fi

  if ! (curl -s https://github.com/yskkin.keys | grep -q "$(cat $keyfile.pub | cut -d' ' -f 1,2)"); then
    echo "Add your SSH key $keyfile.pub via https://github.com/settings/keys"
  fi
}

setup_ssh

if ! which brew &> /dev/null; then
  echo "install Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! which homeshick &> /dev/null; then
  echo "install homeshick..."
  brew install homeshick
fi
export HOMESHICK_DIR="$(brew --prefix)/opt/homeshick"
source "$HOMESHICK_DIR/homeshick.sh"
if ! (homeshick list | grep -q "yskkin/dotfiles"); then
  echo "clone yskkin/dotfiles..."
  homeshick clone git@github.com:yskkin/dotfiles.git
fi

ls $HOME/Brewfile* | grep -v lock | xargs cat | brew bundle --file=-

safe_source $HOME/.zshrc.private
safe_source "$(brew --prefix)/etc/profile.d/z.sh"

if which direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi


if (! test -d ~/.emacs.d || ! git -C ~/.emacs.d status --porcelain &> /dev/null); then
    echo "Cloning spacemacs..."
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

export ZSH="$HOME/.local/share/sheldon/repos/github.com/ohmyzsh/ohmyzsh"
plugins=(
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
  z
)
ZSH_THEME="robbyrussell"
eval $(sheldon source)
