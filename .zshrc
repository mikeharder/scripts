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
# Prompt: current dir + git branch + prompt symbol
# ----------------------------------------------------------------------------
autoload -Uz vcs_info add-zsh-hook
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:git:*' formats '[%b] '
setopt PROMPT_SUBST
PROMPT='${vcs_info_msg_0_}%~ %# '

# ----------------------------------------------------------------------------
# Tools
# ----------------------------------------------------------------------------
command -v fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd --shell zsh)"

# ----------------------------------------------------------------------------
# Git
# ----------------------------------------------------------------------------

## Limit completion to only local branches
export GIT_COMPLETION_CHECKOUT_NO_GUESS="1"

alias g='git'
alias gb='git branch'
alias gc='git checkout'
alias gcl='git clean -xdf'
alias gd='git diff'
alias ge='git commit -m "empty" --allow-empty'
alias gf='git fetch'
alias gl='git log'
alias gm='git merge'
alias gp='git pull'
alias gs='git status'
alias gw='git worktree'
gsync() {
  trap 'set +x' EXIT
  set -x
  git checkout main
  gh repo sync
  git pull
}

## Worktree helpers
alias gwa='~/scripts/git-worktree-add.sh'
alias gwr='~/scripts/git-worktree-remove.sh'

## GitHub CLI
alias gpr='gh pr list'
alias gprme='gh pr list --search "review-requested:@me"'

## Enable git tab-completion for git aliases
compdef g=git
compdef gb=git-branch
compdef gc=git-checkout
compdef gcl=git-clean
compdef gd=git-diff
compdef ge=git-commit
compdef gf=git-fetch
compdef gl=git-log
compdef gm=git-merge
compdef gp=git-pull
compdef gs=git-status
compdef gw=git-worktree
compdef gwr=git-checkout
