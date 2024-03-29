# prevent duplicates in path
typeset -U path

# - - always enable FIPS client in every new session
export OPENSSL_FIPS=1

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="rrplusfullpathinprompt"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

plugins=(git rust golang jsontools git-flow brew node npm macos python sublime)

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

alias vim="nvim" 

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# node env managment
#export NVM_DIR="$HOME/.nvm"
#[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


yes | source $ZSH/oh-my-zsh.sh
 
# User configuration
 
# export MANPATH="/usr/local/man:$MANPATH"
 
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

#export GOPATH=/Users/nat/.gvm/gos/go1.17
export PATH=$GOPATH/bin:$PATH
export GOPROXY="https://go-proxy.crwd.dev,direct"
export GOPRIVATE="go.crwd.dev/*"
export GOSUMDB="off"
export GONOSUMDB="*"
export GOCACHE="/Users/ndavidson/Library/Caches/go-build"
export GOMODCACHE="/Users/ndavidson/go/pkg/mod"
export GOAMD64="v1"

# OpenSSL
export PATH="/opt/homebrew/opt/openssl@1.0/bin:$PATH"
 
# For compilers to find openssl@1.0
export LDFLAGS="-L/opt/homebrew/opt/openssl@1.0/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.0/include"
export RUBY_CFLAGS="-DUSE_FFI_CLOSURE_ALLOC"


# -- Add FIPS client to system path
export PATH="~/ssh_fips/OpenSSH_FIPS_Client/openssl-1.0.2g/apps/:$PATH"
