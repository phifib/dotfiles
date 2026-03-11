# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# bullet-like, but it handle git sync-ly and becomes condiferably slow.
# ZSH_THEME="agnoster"

# a fork of <https://github.com/sindresorhus/pure>
ZSH_THEME="agnoster"
export NVM_HOME=/Users/derek/.nvm

export PATH=${PATH}:${NVM_HOME}

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
#source ${NVM_HOME}/nvm.sh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  z
  zsh-syntax-highlighting
  zsh-autosuggestions
  tmux
)

# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# https://github.com/zsh-users/zsh-completions
#plugins=(zsh-completions)

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
  [ -f ~/dotfiles/zsh/oh-my-zsh/iterm2.zsh ] && source ~/dotfiles/zsh/oh-my-zsh/iterm2.zsh
fi

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

HISTSIZE=10000
HISTFILESIZE=10000

#####################################
# alias
#####################################

# highlight dir from file
alias ls='ls -FHG'


# vim
EDITOR=vim
GIT_EDITOR=vim

alias python=python3

# git
alias ad='git add -a'
alias br='git branch'
alias co='git checkout'
alias cma='git commit -am'
alias cm='git commit -m'
alias cl='git clone'
alias df='git diff'
alias me='git merge'
alias st='git status'
alias sw='git switch'
alias sc='git switch -c'
alias ce='git clone'
alias stash='git stash'
alias ph='git push origin'
alias pl='git pull origin'
alias pull='git pull origin "$(git symbolic-ref --short HEAD)"'
alias push='git push origin "$(git symbolic-ref --short HEAD)"'
alias tag='git tag'

gitall() {
    git add .
    if [ "$1" != "" ]
    then
        git commit -m "$1"
    else
        git commit -m update
    fi
    git push
}
# vs code
alias vs='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'
alias code='/Applications/Cursor.app/Contents/Resources/app/bin/code'

# package.json scripts
alias lint='npm run lint'
alias dev='npm run dev'
alias debug='npm run debug'
alias changelog='conventional-changelog -i CHANGELOG.md -s -r 0'

# 常用工作目录
alias ws='cd ~/work/workspace/'
alias cs='cd ~/codespace/'

# grep (recursive, linenum)
alias greprn='grep -rn'

# ocaml / opam switch (upgrade to opam 2.0)
alias evalopamenv='eval $(opam env)'

# 4.02.3 for Reason/BuckleScript <=5 and Coq 8.4 (JSCert)
alias opamswitch402='opam switch reason && evalopamenv'

# 4.05.* for Coq 8.8.2 (Software Foundation)
alias opamswitch405='opam switch unsafe-str && evalopamenv'

# echo $PATH line by line
alias echopath='tr ":" "\n" <<< "$PATH"'

# cloc coq .v
alias clocv='cloc --by-file-by-lang --match-f=v --exclude-dir="Lib" .'

# langfc
alias fc='./bin/langfc -Ckeep-convert-to-reploc=true -Ckeep-vm-codegen=true'

# Tmux
alias tnew='tmux -f ~/.tmux.conf new-session \; split-window -h \; split-window -v \; attach'

# only eval opam on `source .zshrc` if opam is an executable
if [ -x "$(command -v opam)" ]; then
  eval $(opam config env)
fi

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# permission
alias sudolocalbin='sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/sbin'

# colorful stderr
# https://serverfault.com/questions/59262/bash-print-stderr-in-red-color
# color()(set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[31m&\e[m,'>&2)3>&1
color()(set -o pipefail;"$@" 2>&1 1>&3|sed $'s,.*,\e[31m&\e[m,'1>&2)3>&1

# redefine prompt_context for hiding user@hostname
prompt_context () { }


#####################################
# iTerm - macOS dark mode awareness
# https://apas.gr/2018/11/dark-mode-macos-safari-iterm-vim/
#####################################

if [[ "$(uname -s)" == "Darwin" ]]; then
  sith() {
    val=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
    if [[ $val == "Dark" ]]; then
      i
    fi
  }

i() {
  if [[ $ITERM_PROFILE == "Default" ]]; then
    echo -ne "\033]50;SetProfile=Dark\a"
    export ITERM_PROFILE="Dark"
  else
    echo -ne "\033]50;SetProfile=Default\a"
    export ITERM_PROFILE="Default"
  fi
}

sith
fi

alias iterm-dark-mode="i"


# npm/make/brew autocompletions are super slow. Disable them so that auto-fu's
# completion doesn't trigger for these (compdef 由 oh-my-zsh 提供)
noopt() {}
if (( $+functions[compdef] )); then
  compdef noopt npm make brew
  # See https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org#completing-generic-gnu-commands
  compdef _gnu_generic bsc bsb ocamlc yarn
fi

export PNPM_HOME="/Users/derek/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"


# 如果你不是通过Android Studio安装的sdk，则其路径可能不同，请自行确定清楚
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools



# myIP address
function myip() {
    ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
    ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
    ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
    ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
    ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}


export PATH="$HOME/development/flutter/bin:$PATH"
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PATH=${PATH}:/usr/local/MongoDB/bin

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/Users/derek/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
