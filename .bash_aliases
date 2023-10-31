alias a="nano ~/.bash_aliases; source ~/.bash_aliases"

alias b="git branch"
__git_complete b _git_branch

alias c="git checkout"
__git_complete c _git_checkout

alias l="git log"
__git_complete c _git_log

alias m="git merge"
__git_complete m _git_merge

alias p="git pull"
__git_complete p _git_pull
