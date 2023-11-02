source /usr/share/bash-completion/completions/git

alias a="nano ~/scripts/.bash_aliases; source ~/scripts/.bash_aliases"

alias g="git"
__git_complete g __git_main

alias gb="git branch"
__git_complete gb _git_branch

alias gc="git checkout"
__git_complete gc _git_checkout

alias gd="git diff"
__git_complete gd _git_diff

alias gf="git fetch"
__git_complete gf _git_fetch

alias gl="git log"
__git_complete gl _git_log

alias gm="git merge"
__git_complete gm _git_merge

alias gs="git status"
__git_complete gs _git_status

alias gw="git worktree"
__git_complete gw _git_worktree
