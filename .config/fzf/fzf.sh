
####
####
#### My Custom FZF Options
####
export FZF_DEFAULT_OPTS="--preview '[[ -f {} ]] && bat --style=numbers --color=always --line-range :500 {}' \
  --bind 'ctrl-d:preview-page-down,ctrl-u:preview-page-up' \
  --pointer='󰋇 ' --prompt='󰭎  ' \
  --border=rounded --border-label=' 󱁴  Search ' \
  --color='pointer:#a5cdef'
  "
export FZF_DEFAULT_COMMAND='fd --type f'
  #No preview for shell integration
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
  #Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"
export FZF
