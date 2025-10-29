# # ~/.bash_aliases
# if [ -f ~/scripts/.bash_aliases ]; then
#     . ~/scripts/.bash_aliases
# fi

export PS1='\[\033[01;34m\]\w\[\033[00m\]\$ '

source /usr/share/bash-completion/completions/git

alias a='cat ~/scripts/.bash_aliases'

alias c='clear'

alias ea='nano ~/scripts/.bash_aliases; source ~/scripts/.bash_aliases'

sf() {
  local repo=$(git remote get-url origin | sed -E 's#.*github\.com[:/](.+)\.git#\1#')
  echo "gh repo sync $repo"
  gh repo sync "$repo"
}

alias tp='~/scripts/tsp-packages.py'

# azure-rest-api-specs
alias lintdiff='npm exec --yes -- \
autorest@3.7.1 \
--v3 \
--spectral \
--azure-validator \
--semantic-validator=false \
--model-validator=false \
--openapi-type=data-plane \
--openapi-subtype=data-plane \
--use=@microsoft.azure/openapi-validator@2.2.3'

# azure-rest-api-specs-pr
gapprove() {
    local start=$1
    local end=$2
    for pr in $(seq "$start" "$end"); do
        gh pr review "$pr" --approve
    done
}

# git

## Limit completion to only local branches
export GIT_COMPLETION_CHECKOUT_NO_GUESS="1"

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

alias ge='git commit -m "empty" --allow-empty'

alias gf='git fetch'
__git_complete gf _git_fetch

alias gl='git log'
__git_complete gl _git_log

alias gm='git merge'
__git_complete gm _git_merge

alias gp='git pull'
__git_complete gp _git_pull

alias gpr='gh pr list'

alias gprme='gh pr list --search "review-requested:@me"'

alias gs='git status'
__git_complete gs _git_status

alias gsync='set -x; git checkout main; gh repo sync; git pull; { set +x; } 2>/dev/null'

alias gw='git worktree'
__git_complete gw _git_worktree
