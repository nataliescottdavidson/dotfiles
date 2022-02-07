# If you come from bash you might have to change your $PATH.
#
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/nat/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"


# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git rust golang jsontools git-flow brew node npm macos python sublime)

yes | source $ZSH/oh-my-zsh.sh

alias vim="nvim" 

PROMPT=${PROMPT/\%c/\%~}
[[ -s "/Users/nat/.gvm/scripts/gvm" ]] && source "/Users/nat/.gvm/scripts/gvm"

#export NVM_DIR="$HOME/.nvm"
#[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

alias ewsetup="docker-compose up --force-recreate --build postgres clickhouse-shard &"
alias ewtest="GOFLAGS=\"-mod=vendor -tags=integration\" DB_HOST=0.0.0.0 DEV=auth APP_ENV=dev go test ./test/integration/ -run"

function get-proxy {
  local port=1234
  
  if [ "$(kubectl config current-context)" = 'cfctl-lux-a' ]; then
      port=1235
  fi

  if [ "$(kubectl config current-context)" = 'cfctl-pdx-b' ]; then
      port=1236
  fi

  echo "socks5://127.0.0.1:$port"
}

function kns {
  HTTPS_PROXY=$(get-proxy) kubens $*
}

function kctl() {
    kubectl_bin=/usr/local/bin/kubectl
 
    k8s_colo="pdx"
    k8s_colo_local_port="1234"
 
    if grep "current-context: cfctl-lux-a" .kube/config -q; then
        k8s_colo="lux"
        k8s_colo_local_port="1235"
    fi
 
    proxy="socks5://127.0.0.1:$k8s_colo_local_port"
 
    if ps aux | grep "cloudflared access tcp --hostname api.tun.$k8s_colo-a.k8s.cfplat.com --url 127.0.0.1:$k8s_colo_local_port" | grep -qv "grep"; then
        echo "cloudflared is running..."
    else
        nohup cloudflared access tcp --hostname api.tun.$k8s_colo-a.k8s.cfplat.com --url 127.0.0.1:$k8s_colo_local_port > /dev/null 2>&1 &
    fi
 
    HTTPS_PROXY=$proxy $kubectl_bin $@
}

export GOPATH=/Users/nat/.gvm/gos/go1.17
export PATH=$GOPATH/bin:$PATH
