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

# Set up Homebrew environment 
if command -v brew >/dev/null 2>&1; then
    BREW_PATH=$(which brew)
    eval "$($BREW_PATH shellenv)" 
    #### NVM Options 
    export NVM_DIR="$HOME/.nvm"
       [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
       [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
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
alias ls="eza --icons --all --long --ignore-glob='.git' --sort=modified --reverse"
alias lsa="eza --icons --git-ignore --tree --ignore-glob='.git' | cat"
alias clip="/mnt/c/Windows/System32/clip.exe"
alias copy="tmux save-buffer - | clip"
alias gst="git status"
alias c="clear"
alias batgo="bat --language go" 

export TZ="Africa/Kampala"
export EDITOR=nvim
export ANSIBLE_CONFIG="$HOME/.config/ansible/ansible.cfg"
export PATH="/home/linuxbrew/.linuxbrew/opt/node@20/bin:$PATH"
export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/node@20/lib"
export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/node@20/include"
# NPM_PACKAGES="${HOME}/.npm-packages"
# export PATH="$PATH:$NPM_PACKAGES/bin"
export PATH="$PATH:~/.local/bin/"
# export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
export TERM=xterm-256color
#### NVM Options
# export NVM_DIR="$HOME/.nvm"
#   [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
#   [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"


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
