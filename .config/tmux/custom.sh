
##
##
##
## My Custom Tmux Shell Functions 
##


##
## new-session (with 2 windows)
tn(){
  if [ "$#" -ne 1 ]; then
        echo "Error: This function requires ezactly 1 argument."
        echo "Usage: tn <session-name> "
        return 1  # Return a non-zero status to indicate an error
  fi

  tmux new-session -d -s "$1" -n shell \
    && tmux new-window -t "$1":2 -n repo \
    && tmux select-window -t "$1":1
    # && tmux attach-session -t "$1"
}
