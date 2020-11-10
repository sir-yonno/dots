set fish_greeting
fish_vi_key_bindings

if test (uname) = "Linux"; and test -z "$DISPLAY"
  sx 
end

### globals 
set -gx VOLTA_HOME "$HOME/.volta"
set -gx GOPATH $HOME/go
set -gx EDITOR nvim
if test "(uname)" = "Linux"
  set -gx BROWSER chromium
  set -gx GPG_TTY '$(tty)'
end
source $HOME/.config/colors.sh

### lemonbar configs
set -gx BARS_FONT "LigaOperatorMono Nerd Font:size=12"
set -gx BARS_MARGIN 15
set -gx BARS_HEIGHT 50
set -gx BARS_BG "#1D2021"
set -gx BARS_FG "#EBDBB2"

### modify global $PATH
if test "(uname)" != "Linux"
  set -U fish_user_paths /usr/local/opt/openjdk/bin $fish_user_paths
  set -U fish_user_paths /usr/local/opt/llvm/bin $fish_user_paths
end
set -gx PATH "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" $PATH
set -gx PATH "$HOME/.bin" $PATH
set -gx PATH "$GOPATH/bin" $PATH
set -gx PATH "$VOLTA_HOME/bin" $PATH


### aliases
alias gpg=gpg2 # make gpg work
alias scrcln='rm -rf $HOME/Pictures/screens'

# configure favourite editor
alias vim=$EDITOR
alias vi=$EDITOR

# git alias to manage config filed
# see: https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# always run package managers(apk,pacman) as root
alias apk="doas apk"
alias pacman="sudo pacman"
