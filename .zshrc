# {{{ 环境
Z_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
Z_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
Z_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
# 指定 DATA 和 CACHE 目录必须确保该目录存在
# 否则 zsh 无法写入，zsh 不会主动创建这些目录
[[ ! -d "${Z_DATA_DIR}" ]] && mkdir -p "${Z_DATA_DIR}"
[[ ! -d "${Z_CACHE_DIR}" ]] && mkdir -p "${Z_CACHE_DIR}"

Z_COMP_DIR="${Z_CACHE_DIR}"
Z_COMPDUMP_PATH="${Z_COMP_DIR}/zcompdump"
Z_COMPCACHE_DIR="${Z_COMP_DIR}/zcompcache"
# }}}

### Aliases
alias cat='bat'
function ssh() {
    kitty +kitten ssh "$@"
}

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	  zsh-autosuggestions
	  zsh-syntax-highlighting
	  git
	  screen
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# {{{ 选项
setopt correct                        # 改正输错的命令
setopt interactive_comments           # 交互模式允许注释
HISTSIZE=10000
SAVEHIST=100000
setopt share_history                  # 多个实例共享历史记录
setopt hist_ignore_dups               # 不记录多条连续重复的历史
setopt hist_reduce_blanks             # 删除历史记录中的空行
setopt hist_find_no_dups              # 查找历史记录时忽略重复项
setopt hist_ignore_space              # 不记录空格开头的命令
setopt extended_history               # 记录时间戳
# }}}

### yazi
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
	      builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# {{{ customized functions
# beancount
function self_beancount() {
    eval "conda activate beancount"
    eval "cd ~/Documents/Bills"
    eval "xdg-open http://127.0.0.1:5000; fava main.bean"
    eval "cd; conda deactivate"
}

# compress images
function self_compress_images() {
    conda activate tools
    python "/data/xiaoyaosheny/Projects/Tools/compress.py" --input_dir "$1" $2
    conda deactivate
}

# rename images
function self_rename_iamges() {
    conda activate tools
    python "/data/xiaoyaosheny/Projects/Tools/rename.py" --input_dir "$1"
    conda deactivate
}

# filter images
function self_filter_images() {
    conda activate tools
    python "/data/xiaoyaosheny/Projects/Tools/filter_images.py" --input_dir "$1" --output_dir "$2"
    conda deactivate
}

# download music from links
function self_download_music() {
    yt-dlp --format "ba[ext=m4a]" --embed-metadata --extract-audio --audio-format mp3 \
        --cookies-from-browser chromium --output "~/Music/%(title)s.mp3" "$1"
}

# }}}

### fastfetch
random_fastfetch() {
  local themes=(/usr/share/fastfetch/presets/examples/*.jsonc)
  command fastfetch --config "${themes[RANDOM % ${#themes[@]}]}"
}
if [[ $(tty) == *"pts"* ]]; then
  random_fastfetch
else
  echo "Welcome"
fi

# Set up fzf key bindings
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="--style full --bind 'focus:transform-header:file --brief {}'"
alias fzfp="fzf --preview 'fzf-preview.sh {}'"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/xiaoyaosheny/.config/.dart-cli-completion/zsh-config.zsh ]] && . /home/xiaoyaosheny/.config/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

# zoxide
eval "$(zoxide init zsh)"

### proxyman
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

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# huggingface mirror
export HF_ENDPOINT=https://hf-mirror.com

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/data/xiaoyaosheny/Programs/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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
export MAMBA_EXE='/data/xiaoyaosheny/Programs/miniforge3/bin/mamba';
export MAMBA_ROOT_PREFIX='/data/xiaoyaosheny/Programs/miniforge3';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# 修复 conda 导致 clear 命令失效
alias clear=/usr/bin/clear

# flutter
export PATH="/data/xiaoyaosheny/Programs/flutter/bin:$PATH"
export CHROME_EXECUTABLE=/usr/bin/chromium
