# Suppress Fish's greeting
set fish_greeting

# Pipes any --help output through bat and then ov, the BATPAGER. Would prefer to use the regex option, but cannot get it to work with the $ anchor
# abbr --add --position anywhere -- --help '(\S+)\s--help$ | bat -pl help'
# I use batcat here instead of just bat because I'm currently on Debian
abbr --add --position anywhere -- --help "--help | batcat -plhelp"

# DOS style CLS to clear screen
abbr --add cls clear

# for gplates on Wayland
abbr --add gplates "QT_QPA_PLATFORM=xcb gplates"

# for todotxt-cli
abbr --add t "todo-txt -d ~/Documents/todo/.todo.cfg"

# XDG Base Directories
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx XDG_CACHE_HOME $HOME/.cache

# Path modifications
fish_add_path -aP ~/.local/bin
# fish_add_path -a ~/.config/emacs/bin
# golang
# fish_add_path -a /usr/local/go/bin /home/corey/go/bin
# for LM Studio CLI tool (lms)
# fish_add_path -a /home/corey/.cache/lm-studio/bin
# for BunJS which I use for the VLC extension
# fish_add_path -aP ~/.bun/bin

# For cargo built binaries (Couldn't get to work. Trying a plugin instead)
# fish_add_path -a ~/.cargo/bin

# More golang path stuff
set -gx GOROOT /usr/local/go
set -gx GOPATH /home/corey/go

# Editor Environment Variables
set -gx MICRO_TRUECOLOR 1 # Needed for Micro color themes
set -gx EDITOR hx

# Make sure nvim gets passed through mullvad-exclude
# abbr --add nvim "mullvad-exclude nvim"

# Choose editor for edit my config command
# set --export EMC_EDITOR micro
set --export EMC_EDITOR chezmoi edit

# Fish-exa Environment Variables
set -gx EXA_STANDARD_OPTIONS --icons --color=always --header --group-directories-first
set -gx EXA_LL_OPTIONS --long --all --created --modified --mounts # extra long format
set -gx EXA_L_OPTIONS -x --icons --color=always --group-directories-first

# Pager Environment Variables
set -gx PAGER ov # moar as backup somethimes when ov has issues with nb
set -gx MANROFFOPT -c # Color compatibility rendering for manpagers in ov
set -gx MANPAGER ov --section-delimiter '^[A-Z]' --section-header
set -gx BAT_PAGER ov -F -H3
set -gx GIT_PAGER delta
set -gx DELTA_PAGER ov --section-delimiter '^(commit|added:|removed:|renamed:|Δ)' --section-header --pattern '•'

###### FISH PLUGIN WORKS POORLY ... CURRENTLY UNINSTALLED ################################################
# FZF/Fzf.Fish Environment Variables (forget what these all do)
# These 2 lines are from FD helpfile but adpated to fish
set -gx FZF_DEFAULT_COMMAND fd --type file --color=always
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
# set -gx FZF_DEFAULT_OPTS --ansi # --ansi might slow things down here. Need to investigate
# --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
# --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
# --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
# Tell Fzf.Fish to use exa instead of ls (no export needed) (might already be handled since ls is aliased?)
# set fzf_preview_dir_cmd exa --all
# Similarly for batcat
# set fzf_preview_file_cmd batcat -n
##########################################################################################################

# Zoxide / Zoxide.Fish Environment Variables
# Might not be good to be universal, but I couldn't get it to work otherwise.
# This could be because the variable needs to be set before the plugin, so we
# may need to move a different version of this command outside of this file.
if not set -q zoxide_cmd # Check if variable is NOT already set
    set -U zoxide_cmd cd
end

# SHOULD Tell GTK apps to use native file pickers and such.
set -gx GTK_USE_PORTAL 1

# ATTEMPT to make non-native apps (appimages) use correct themeing
# set -gx QT_STYLE_OVERRIDE "breeze" # Or "gtk2", "windows", etc.
# set -gx QT_QPA_PLATFORMTHEME "plasma"

# Setup Proxy for terminal apps
# set -gx https_proxy socks5://10.64.0.1:1080
# set -gx http_proxy socks5://10.64.0.1:1080

# Necessary since 'chezmoi cd' doesn't change directories, it spawns a new shell
# May want to move this into a separate file later if I amass many functions
# function chezmoi-cd
#    cd (chezmoi source-path)
# end

# Additional zoxide.fish settings
# set -U _ZO_ECHO 1 # When set to 1, zoxide.fish prints the matched directory before navigating to it.
# set -U _ZO_RESOLVE_SYMLINKS 1 # When set to 1 zoxide.fish will resolve symlinks before adding directories to the database.

# Get the fuck working
# thefuck --alias | source

# # Itegrate Navi as shell widget. Might want to replace with a plugin if possible (like starship and direnv)
# I rarely use this, so commenting out temporarily until I decide to keep it or not.
navi widget fish | source

# Rice this bitch
fastfetch

# Yazi Shell wrapper https://yazi-rs.github.io/docs/quick-start
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Starship Prompt
# starship init fish | source # Not necessary if using fisher add wawa19933/starship.fish
# Prolly doesn't go in this file. Necessary config for Tide prompt. Investigating using Starship again though.
# tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Sparse --icons='Few icons' --transient=Yes

# Variable for compiling Mudlet
# LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/corey/projects/mudlet/3rdparty/discord/rpc/lib/

### Old longer Fisher Plugin list
# jorgebucaran/fisher				# Main Plugin
# patrickf1/fzf.fish 				# Problematic results (runs fastfetch in preview)
# gazorby/fish-abbreviation-tips	# Need to re-evaluate
# nickeb96/puffer-fish				# Need to re-evaluate
# gazorby/fish-exa					# SEEMS TO WORK
# kidonng/zoxide.fish				# SEEMS TO WORK

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/corey/.lmstudio/bin

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
