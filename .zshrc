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
compdef g=git
alias gb='git branch'
compdef gb=git-branch
alias gc='git checkout'
compdef gc=git-checkout
alias gcl='git clean -xdf'
compdef gcl=git-clean
alias gd='git diff'
compdef gd=git-diff
alias ge='git commit -m "empty" --allow-empty'
compdef ge=git-commit
alias gf='git fetch'
compdef gf=git-fetch
alias gl='git log'
compdef gl=git-log
alias gm='git merge'
compdef gm=git-merge
alias gp='git pull'
compdef gp=git-pull
alias gs='git status'
compdef gs=git-status
alias gw='git worktree'
compdef gw=git-worktree

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
compdef gwr=git-checkout

## GitHub CLI
alias gpr='gh pr list'
alias gprme='gh pr list --search "review-requested:@me"'
