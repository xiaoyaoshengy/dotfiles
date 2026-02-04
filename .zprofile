typeset -U path PATH
path=($path ~/.bin)

### XDG 目录
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

### 默认程序
export EDITOR=nvim
export BROWSER=chromium

### Zsh
export HISTFILE="${XDG_DATA_HOME}/zsh/history"

### 终端
export MANPAGER="nvim +Man!"

### Go
export GOPATH="${XDG_DATA_HOME}/go"

### Javascript
export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

### Python
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/repl_startup.py"
export PYTHONPYCACHEPREFIX="${XDG_CACHE_HOME}/python"
export PYTHONUSERBASE="${XDG_DATA_HOME}/python"
export IPYTHONDIR="${XDG_DATA_HOME}/ipython"

### Rust
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

### SQLite
export SQLITE_HISTORY="${XDG_DATA_HOME}/sqlite_history"

### Docker
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

### CUDA
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}/nv"

### nvm
export NVM_DIR="${XDG_DATA_HOME}/nvm"

### wget
export WGETRC="${XDG_CONFIG_HOME}/wgetrc"

# {{{ 图形环境
export XDG_MENU_PREFIX=plasma-

# 鼠标主题
export XCURSOR_PATH="${XDG_DATA_HOME}/icons:/usr/share/icons"

### Qt
# 禁止 Qt 自动缩放，用 xrdb 手动设置 DPI
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_ENABLE_HIGHDPI_SCALING=0

### GTK
# 配合 xdg-desktop-portal-kde 使用
export GTK_USE_PORTAL=1

### Fcitx
export XMODIFIERS=@im=fcitx
unset GTK_IM_MODULE
unset QT_IM_MODULE
# Kitty 需要该变量
export GLFW_IM_MODULE=ibus
# }}}

export LANG=zh_CN.utf8

# 同步所有环境变量到所有 systemd 将要启动的程序
command -v dbus-update-activation-environment &>/dev/null && \
  dbus-update-activation-environment --systemd --all 2>/dev/null
