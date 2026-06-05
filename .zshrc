# Add to ~/.zshrc:
#
# if [ -f ~/scripts/.zshrc ]; then
#   . ~/scripts/.zshrc
# fi

# Custom prompt: git branch + current dir + prompt symbol
autoload -Uz vcs_info add-zsh-hook
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:git:*' formats '[%b] '
setopt PROMPT_SUBST
PROMPT='${vcs_info_msg_0_}%~ %# '

command -v fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd --shell zsh)"
