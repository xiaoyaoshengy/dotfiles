# {{{ 环境
export HISTFILE="${XDG_STATE_HOME}/zsh/history"
# }}}

# {{{ 别名
alias cat='bat'
function ssh() {
    kitty +kitten ssh "$@"
}
# }}}

# {{{ PATH
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# }}}

# {{{ oh-my-zsh
# Path to your Oh My Zsh installation.
export ZSH=/usr/share/oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    screen
)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
    mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
# }}}

# {{{ zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# }}}

# {{{ 选项
setopt correct              # 改正输错的命令
setopt interactive_comments # 交互模式允许注释
HISTSIZE=10000
SAVEHIST=100000
setopt share_history      # 多个实例共享历史记录
setopt hist_ignore_dups   # 不记录多条连续重复的历史
setopt hist_reduce_blanks # 删除历史记录中的空行
setopt hist_find_no_dups  # 查找历史记录时忽略重复项
setopt hist_ignore_space  # 不记录空格开头的命令
setopt extended_history   # 记录时间戳
# }}}

# {{{ yazi
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}
# }}}

# {{{ customized functions
# download music from links
function self_download_music() {
    yt-dlp --format "ba[ext=m4a]" --embed-metadata --extract-audio --audio-format mp3 \
        --cookies-from-browser chromium --output "~/Music/%(title)s.mp3" "$1"
}

# upload file/folder to server by rsync
function rsync_to_server() {
    rsync -avz "$1" "$2@$3:$4"
}
# download file/folder from server by rsync
function rsync_from_server() {
    rsync -avz "$1@$2:$3" "$4"
}

# }}}

# {{{ fastfetch
random_fastfetch() {
    local themes=(/usr/share/fastfetch/presets/examples/*.jsonc)
    command fastfetch --config "${themes[RANDOM % ${#themes[@]}]}"
}
if [[ $(tty) == *"pts"* ]]; then
    random_fastfetch
else
    echo "Welcome"
fi
# }}}

# {{{ fzf
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="--style full --bind 'focus:transform-header:file --brief {}'"
alias fzfp="fzf --preview 'fzf-preview.sh {}'"
# }}} Set up fzf key bindings

# {{{ dart
## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/xiaoyaosheny/.config/.dart-cli-completion/zsh-config.zsh ]] && . /home/xiaoyaosheny/.config/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]
# }}}

# {{{ zoxide
eval "$(zoxide init zsh)"
# }}}

# {{{ huggingface mirror
export HF_ENDPOINT=https://hf-mirror.com
# }}}

# {{{ conda
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/data/xiaoyaosheny/Programs/miniforge3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/data/xiaoyaosheny/Programs/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/data/xiaoyaosheny/Programs/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/data/xiaoyaosheny/Programs/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/data/xiaoyaosheny/Programs/miniforge3/bin/mamba'
export MAMBA_ROOT_PREFIX='/data/xiaoyaosheny/Programs/miniforge3'
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE" # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# 修复 conda 导致 clear 命令失效
alias clear=/usr/bin/clear
# }}}

# {{{ flutter
export CHROME_EXECUTABLE=/usr/bin/helium-browser
# 镜像
export PUB_HOSTED_URL="https://pub.flutter-io.cn"
export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
# 别名
alias flutter="fvm flutter"
alias dart="fvm dart"
# }}}

# {{{ nvm
source /usr/share/nvm/init-nvm.sh
# }}}

# {{{ pnpm
export PNPM_HOME="/home/xiaoyaosheny/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# }}}

# {{{ proxyman
export http_proxy="http://127.0.0.1:7890/"
export ftp_proxy="ftp://127.0.0.1:7890/"
export rsync_proxy="rsync://127.0.0.1:7890/"
export no_proxy="localhost,127.0.0.1,192.168.1.1,::1,*.local"
export HTTP_PROXY="http://127.0.0.1:7890/"
export FTP_PROXY="ftp://127.0.0.1:7890/"
export RSYNC_PROXY="rsync://127.0.0.1:7890/"
export NO_PROXY="localhost,127.0.0.1,192.168.1.1,::1,*.local"
export https_proxy="http://127.0.0.1:7890/"
export HTTPS_PROXY="http://127.0.0.1:7890/"
# }}}

# {{{ android
export ANDROID_HOME=/data/xiaoyaosheny/Programs/android/sdk
# }}}

# {{{ 自动补全
source "${XDG_CONFIG_HOME}/zsh/completions/crush.zsh"
source "${XDG_CONFIG_HOME}/zsh/completions/openlist.zsh"
source "${XDG_CONFIG_HOME}/zsh/completions/self_tools.zsh"
# }}}
