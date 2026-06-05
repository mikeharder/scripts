# Add to ~/.zshrc:
#
# if [ -f ~/scripts/.zshrc ]; then
#   . ~/scripts/.zshrc
# fi

# Custom prompt: current dir + git branch + prompt symbol
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '[%b] '
setopt PROMPT_SUBST
PROMPT='${vcs_info_msg_0_}%~ %# '

eval "$(fnm env --use-on-cd --shell zsh)"
