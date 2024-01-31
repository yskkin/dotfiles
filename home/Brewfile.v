tap "auth0/auth0-cli"
tap "azure/functions"
tap "homebrew/bundle"
tap "homebrew/cask-versions"
tap "homebrew/services"

brew "awscli"
brew "azure-cli"
brew "ffmpeg"
brew "libpq"
brew "postgresql@11", restart_service: true
brew "auth0/auth0-cli/auth0"
brew "azure/functions/azure-functions-core-tools@4"

cask "around"
cask "mkvtoolnix"
cask "ngrok"
cask "vlc"
cask "zoom"
