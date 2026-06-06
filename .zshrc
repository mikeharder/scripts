# Add to ~/.zshrc:
#
# if [ -f ~/scripts/.zshrc ]; then
#   . ~/scripts/.zshrc
# fi

# ----------------------------------------------------------------------------
# Completion
# ----------------------------------------------------------------------------
autoload -Uz compinit && compinit

# ----------------------------------------------------------------------------
# Prompt: git branch + current dir + prompt symbol
# ----------------------------------------------------------------------------
autoload -Uz vcs_info add-zsh-hook
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:git:*' formats '[%b] '
setopt PROMPT_SUBST
PROMPT='${vcs_info_msg_0_}%~ %# '

# ----------------------------------------------------------------------------
# Tools
# ----------------------------------------------------------------------------
[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
command -v fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd --shell zsh)"

# ----------------------------------------------------------------------------
# Git
# ----------------------------------------------------------------------------

## Limit completion to only local branches
export GIT_COMPLETION_CHECKOUT_NO_GUESS="1"

alias g='git'
compdef g=git
alias gb='git branch'
compdef _git gb=git-branch
alias gc='git checkout'
compdef _git gc=git-checkout
alias gcl='git clean -xdf'
compdef _git gcl=git-clean
alias gd='git diff'
compdef _git gd=git-diff
alias ge='git commit -m "empty" --allow-empty'
compdef _git ge=git-commit
alias gf='git fetch'
compdef _git gf=git-fetch
alias gl='git log'
compdef _git gl=git-log
alias gm='git merge'
compdef _git gm=git-merge
alias gp='git pull'
compdef _git gp=git-pull
alias gs='git status'
compdef _git gs=git-status
alias gw='git worktree'
compdef _git gw=git-worktree

alias gsync='set -x; git checkout main; gh repo sync; git pull; { set +x; } 2>/dev/null'

## Worktree helpers
alias gwa='~/scripts/git-worktree-add.sh'
alias gwr='~/scripts/git-worktree-remove.sh'
compdef _git gwr=git-checkout

## GitHub CLI
alias gpr='gh pr list'
alias gprme='gh pr list --search "review-requested:@me"'
