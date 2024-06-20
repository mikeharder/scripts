# # ~/.bash_aliases
# if [ -f ~/scripts/.bash_aliases ]; then
#     . ~/scripts/.bash_aliases
# fi

source /usr/share/bash-completion/completions/git

alias a='alias'

alias ea='nano ~/scripts/.bash_aliases; source ~/scripts/.bash_aliases'

alias sf='~/scripts/sync-forks.sh'
alias tp='~/scripts/tsp-packages.py'

# azure-rest-api-specs
alias lintdiff='npm exec --yes -- \
autorest@3.6.1 \
--v3 \
--spectral \
--azure-validator \
--semantic-validator=false \
--model-validator=false \
--openapi-type=data-plane \
--openapi-subtype=data-plane \
--use=@microsoft.azure/openapi-validator@2.2.0'

# git
alias g='git'
__git_complete g __git_main

alias gb='git branch'
__git_complete gb _git_branch

alias gc='git checkout'
__git_complete gc _git_checkout

alias gcl='git clean -xdf'
__git_complete gcl _git_clean

alias gd='git diff'
__git_complete gd _git_diff

alias gf='git fetch'
__git_complete gf _git_fetch

alias gl='git log'
__git_complete gl _git_log

alias gm='git merge'
__git_complete gm _git_merge

alias gp='git pull'
__git_complete gp _git_pull

alias gs='git status'
__git_complete gs _git_status

alias gw='git worktree'
__git_complete gw _git_worktree
