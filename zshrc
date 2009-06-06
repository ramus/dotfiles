# my silly prompt {{{
autoload -U promptinit
promptinit
prompt adam2 gray yellow green white
RPS1='[%*]'
# }}}
# completion {{{
#. ~/.zshcomplete
autoload -U compinit
compinit
# }}}
# history {{{
HISTFILE=$HOME/.history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
setopt share_history
setopt hist_ignore_space
# }}}
# plugins {{{
autoload copy-earlier-word
zle -N copy-earlier-word

autoload edit-command-line
zle -N edit-command-line
# }}}
export EDITOR=/usr/bin/vim
# miscellaneous options {{{
setopt nobeep
setopt auto_cd
setopt multios
setopt extended_glob
setopt nullglob
setopt list_ambiguous
setopt no_nomatch
setopt interactivecomments
setopt listpacked
setopt complete_in_word
# }}}
# key bindings {{{
bindkey -v                           # Use vim bindings
bindkey "^A" beginning-of-line       # Easier than ^[I
bindkey "^E" end-of-line             # Easier than ^[A
bindkey "^N" accept-and-infer-next-history # Enter; pop next history event
bindkey "^P" push-line               # Pushes line to buffer stack
bindkey "^R" history-incremental-search-backward # Like in bash, but should !
bindkey "^Y" copy-earlier-word       # Pretty self-explanatory name!
bindkey "^T" transpose-chars         # Transposes adjacent chars (xp in vim)
bindkey " " magic-space              # Expands from hist (!vim )
bindkey "\e[3~" delete-char          # Enable delete
bindkey -M vicmd v edit-command-line # v in vi mode opens line in $EDITOR
# }}}
# replace default utilities {{{
#alias man="man -P vimmanpager"
#alias top="htop"
# }}}
# add color to some things {{{
alias ls='ls --color'
alias grep='grep --color=auto'
# }}}
# telnet services (nao, termcast, etc) {{{
alias nao="(TERM='rxvt'; telnet nethack.alt.org)"
alias termcast="telnet termcast.org"
# }}}
# shell accounts {{{
# }}}
# shortcuts {{{
alias ll='ls -lhA'
alias less='less -R'
#alias start_termcast='export IN_TTYREC=1 && ttyrec ~/app/ttrtail/termcast.ttyrec'
# }}}
# darcs shortcuts {{{
alias dwn="darcs whatsnew"
alias darcsify="darcs init && darcs add \$(darcs whatsnew -ls | awk '/^a\ / {print \$2}') && darcs record -a -m'Initial import'"
alias dpl="darcs pull"
alias dps="darcs push"
alias dpa="darcs push --all"
alias dp="darcs pull && darcs push"
alias dr="darcs record"
alias dar="darcs amend-record"
alias db="darcs revert"
alias dsf="darcs show files"
alias dun="darcs unpull"
alias dur="darcs unrecord"
alias dB="darcs unrecord"
alias drb="darcs rollback"
# }}}
