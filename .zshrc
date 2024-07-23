# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dst" # set by `omz`

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
plugins=(git fzf)
source $ZSH/oh-my-zsh.sh


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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#alias fd="fzf"
cpp(){
g++ $1 -o /tmp/m && chmod +x /tmp/m && /tmp/m
}
# v for video downloading
# v QUALITY LINK
v(){
if [ $1 = "2" ]; then
  yt-dlp -f "worst[height>=240]" --no-playlist $2
elif [ $1 = "3" ]; then
  yt-dlp -f "worst[height>=360]" --no-playlist $2
elif [ $1 = "4" ]; then
  yt-dlp -f "worst[height>=480]" --no-playlist $2
elif [ $1 = "7" ]; then
  yt-dlp -f "worst[height>=720]" --no-playlist $2
else
  echo "Invalid argument"
fi
}
qemu-android(){
qemu-kvm -soundhw es1370 -net nic -net user -cdrom \
${@:-out/target/product/eeepc/eeepc.iso}
}
# Environment Variables-------------------->
#
# Plugins conf
export FZF_BASE=/home/pxlman/.config/fzf
export FZF_DEFAULT_COMMAND='fd'
#DISABLE_FZF_AUTO_COMPLETION="false"
export DISABLE_FZF_KEY_BINDINGS="true" # CTRL-T,CTRL-R,CTRL,ALT-C
export _JAVA_AWT_WM_NONREPARENTING=1
# This is to solve vulkan error in steam
# U must make sure to install the needed vulkan drivers (these files r there)
# packages(i think): vulkan-intel vulkan-headers vulkan-tools 
export VK_DRIVER_FILES=/usr/share/vulkan/icd.d/intel_icd.i686.json:/usr/share/vulkan/icd.d/intel_icd.x86_64.json
export LIBVA_DRIVER_NAME=x86_64 VDPAU_DRIVER=va_gl
export LIBVA_DRIVERS_PATH=/usr/lib/dri/iHD_drv_video.so
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:$HOME/.myapps
export PATH=$PATH:$HOME/.mycmds
export EDITOR=nvim
# After you `python -m venv $HOME/.venv`
# source ~/.venv/bin/activate
# Aliases ----------------->
alias nvimrc="nvim .dotfiles/.config/nvim/lua/pxlman"
alias t="tree -a ."
alias snooze='pkill graySleep;xgamma -gamma 1'
# alias heroic=$HOME/.myapps/Heroic.AppImage
alias h=helix
# alias python=~/.venv/bin/python
# alias pip=~/.venv/bin/pip
alias docker="sudo docker"
