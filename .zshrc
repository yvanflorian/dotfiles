bindkey -v

# cd "$HOME"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
# Bring process back to foreground with Ctrl-A
bindkey -s '^A' 'fg\n'

# Set up Homebrew environment 
if command -v brew >/dev/null 2>&1; then
    BREW_PATH=$(which brew)
    BREW_PREFIX=$(brew --prefix)
    eval "$($BREW_PATH shellenv)" 
    #### NVM Options 
    export NVM_DIR="$HOME/.nvm"
       [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
       [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
    #### libpq to path
    export PATH="$BREW_PREFIX/opt/libpq/bin:$PATH"
fi

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey '^[[1;5C' forward-word
bindkey '^ ' autosuggest-fetch


###
### Aliases
###
#alias nvim="~/nvim.appimage"
alias catlarge="cat"
alias cat="bat"
alias catp="bat --style=plain"
#alias ls="eza --icons --all --long --ignore-glob='.git' --sort=modified --reverse"
#alias lsa="eza --icons --git-ignore --tree --ignore-glob='.git' | cat"
alias ls="ls -lhAptG --color"
alias gst="git status"
alias c="clear"
alias batgo="bat --language go" 

alias uuidv7="npx uuidv7"
alias vim="nvim"
#
# OS Specific Copy
case "$(uname)" in
  Darwin*)
    # Your macOS specific configurations here
    alias clip="pbcopy"
    alias base64="gbase64"
    alias copy="tmux show-buffer | pbcopy"
    alias uuidgen="uuidgen | tr '[:upper:]' '[:lower:]'"
    # Add more macOS specific stuff
    ;;
    
  # WSL
  Linux*)
    alias clip="/mnt/c/Windows/System32/clip.exe"
    alias copy="tmux save-buffer - | clip"
    # Add more Linux specific stuff
    ;;
esac

export TZ="Africa/Kampala"
export EDITOR=nvim
export ANSIBLE_CONFIG="$HOME/.config/ansible/ansible.cfg"
export PATH="/home/linuxbrew/.linuxbrew/opt/node@22/bin:$PATH"
export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/node@22/lib"
export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/node@22/include"
# NPM_PACKAGES="${HOME}/.npm-packages"
# export PATH="$PATH:$NPM_PACKAGES/bin"
export PATH="$PATH:~/.local/bin/"
export TERM=xterm-256color


##
## Type v to edit the current line in the editor
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line


## Custom scripts
source "$HOME/.config/fzf/fzf.sh"
source "$HOME/.config/tmux/custom.sh"
source "$HOME/.config/zsh/index.sh"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(fzf --zsh)"

export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

# neofetch (but not everytime i open new window in tmux)
if [[ -z "$TMUX" ]]; then
  cd $HOME && neofetch
fi

# pnpm
export PNPM_HOME="/home/yvanflorian/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end 

# Go Binaries
GOPATH="$(go env GOPATH)/bin"
export PATH="$GOPATH:$PATH"
export PATH="$HOME/.local/bin:$PATH"
source "$HOME/.config/op/plugins.sh"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=("$HOME/.docker/completions" $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# Enable case-insensitive completion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# Configure completion style for make
zstyle ':completion:*:make:*' tag-order 'targets'
# Fuzzy search through make targets
#
# PNPM
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
json_stringify(){
  echo "$1" | jq -R .
}
alias vimt="NVIM_APPNAME=nvim-kickstart nvim"
