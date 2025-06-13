#  Startup 
# Commands to execute on startup (before the prompt is shown)

# Check if the interactive shell option is set
if [[ $- == *i* ]]; then
    # This is a good place to load graphic/ascii art, display system information, etc.
    if command -v pokego >/dev/null; then
        pokego --no-title -r 1,3,6
    elif command -v pokemon-colorscripts >/dev/null; then
        pokemon-colorscripts --no-title -r 1,3,6
    elif command -v fastfetch >/dev/null; then
        if do_render "image"; then
            fastfetch
        fi
    fi
fi
# fastfetch.sh

#  Aliases 
# Override aliases here or in '~/.zshrc' (already set in .zshenv)

# # Helpful aliases
alias c='clear'                                                        # clear terminal

# ls
alias l='eza -lh --icons=auto'                                         # long list
alias ls='eza -1 --icons=auto'                                         # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto'                                       # long list dirs
alias lt='eza --icons=auto --tree'                                     # list folder as tree

# alias un='$aurhelper -Rns'                                             # uninstall package
# alias up='$aurhelper -Syu'                                             # update system/package/aur
# alias pl='$aurhelper -Qs'                                              # list installed package
# alias pa='$aurhelper -Ss'                                              # list available package
# alias pc='$aurhelper -Sc'                                              # remove unused cache
# alias po='$aurhelper -Qtdq | $aurhelper -Rns -'                        # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
# alias vc='code'                                                        # gui code editor

alias fastfetch='fastfetch --logo-type kitty'
alias update-all='sudo pacman -Syu --noconfirm archlinux-keyring;yay -Syu --noconfirm; flatpak update -y; mise self-update;mise upgrade'
alias cat='bat --theme=ansi'
alias htop='btop'

# ip addresses
alias publicip='echo "IPv4: $(curl -4 -s icanhazip.com)"; echo "IPv6: $(curl -6 -s icanhazip.com)"'
alias localip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'"

# # Directory navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias ..g=' cd "$(git rev-parse --show-toplevel)"' # goto git root

# # Always mkdir a path (this doesn't inhibit functionality to make a single dir)
# alias mkdir='mkdir -p'

#  Plugins 
# manually add your oh-my-zsh plugins here
plugins=(
    "sudo"
    "git"                     # (default)
    "zsh-autosuggestions"     # (default)
    "zsh-syntax-highlighting" # (default)
    "zsh-completions"         # (default)
)
alias config='/usr/bin/git --git-dir=/home/justin/.dotfiles/ --work-tree=/home/justin'
