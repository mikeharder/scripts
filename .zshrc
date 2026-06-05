# Add the following to ~/.zshrc:
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
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '[%b] '
setopt PROMPT_SUBST
PROMPT='${vcs_info_msg_0_}%~ %# '

# ----------------------------------------------------------------------------
# Tools
# ----------------------------------------------------------------------------
eval "$(fnm env --use-on-cd --shell zsh)"

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
alias gsync='set -x; git checkout main; gh repo sync; git pull; { set +x; } 2>/dev/null'

## Worktree helpers
alias gwa='~/scripts/git-worktree-add.sh'
alias gwr='~/scripts/git-worktree-remove.sh'

## GitHub CLI
alias gpr='gh pr list'
alias gprme='gh pr list --search "review-requested:@me"'

## Enable git tab-completion for git aliases
for a in g gb gc gcl gd gf gl gm gp gs gw gwr; do
  compdef $a=git
done
unset a
