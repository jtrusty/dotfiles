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

# # FZF
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'

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

alias fzf='fzf --preview "bat --style=numbers --color=always --line-range :500 {}"' # preview files in fzf
alias fastfetch='fastfetch --logo-type kitty'
alias update-all='sudo pacman -Syu --noconfirm archlinux-keyring;yay -Syu --noconfirm; flatpak update -y; mise self-update;mise upgrade'
alias cat='bat --theme=ansi'
alias htop='btop'
alias look="find . -name"
alias search="grep --color -rnw ./ -e "
alias ports="lsof -PiTCP -sTCP:LISTEN"

# # IP Addresses
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
alias mkdir='mkdir -p'

#  Plugins 
# manually add your oh-my-zsh plugins here
plugins=(
    "sudo"
    "zsh-autosuggestions"     # (default)
    "zsh-syntax-highlighting" # (default)
    "zsh-completions"         # (default)
    "git"                     # (default)
)

# # Dotfiles
alias config='/usr/bin/git --git-dir=/home/justin/.dotfiles/ --work-tree=/home/justin'

# # Git Functions for Logs
LOG_HASH="%C(always,yellow)%h%C(always,reset)"
LOG_RELATIVE_TIME="%C(always,green)(%ar)%C(always,reset)"
LOG_AUTHOR="%C(always,blue)<%an>%C(always,reset)"
LOG_REFS="%C(always,red)%d%C(always,reset)"
LOG_SUBJECT="%s"

LOG_FORMAT="$LOG_HASH}$LOG_AUTHOR}$LOG_RELATIVE_TIME}$LOG_SUBJECT $LOG_REFS"

BRANCH_PREFIX="%(HEAD)"
BRANCH_REF="%(color:red)%(color:bold)%(refname:short)%(color:reset)"
BRANCH_HASH="%(color:yellow)%(objectname:short)%(color:reset)"
BRANCH_DATE="%(color:green)(%(committerdate:relative))%(color:reset)"
BRANCH_AUTHOR="%(color:blue)%(color:bold)<%(authorname)>%(color:reset)"
BRANCH_CONTENTS="%(contents:subject)"

BRANCH_FORMAT="}$BRANCH_PREFIX}$BRANCH_REF}$BRANCH_HASH}$BRANCH_DATE}$BRANCH_AUTHOR}$BRANCH_CONTENTS"

show_git_head() {
    pretty_git_log -1
    git show -p --pretty="tformat:"
}

pretty_git_log() {
    git log --since="6 months ago" --graph --pretty="tformat:${LOG_FORMAT}" $* | pretty_git_format | git_page_maybe
}

pretty_git_log_all() {
    git log --all --since="6 months ago" --graph --pretty="tformat:${LOG_FORMAT}" $* | pretty_git_format | git_page_maybe
}


pretty_git_branch() {
    git branch -v --color=always --format=${BRANCH_FORMAT} $* | pretty_git_format
}

pretty_git_branch_sorted() {
    git branch -v --color=always --format=${BRANCH_FORMAT} --sort=-committerdate $* | pretty_git_format
}

pretty_git_format() {
    # Replace (2 years ago) with (2 years)
    sed -Ee 's/(^[^)]*) ago\)/\1)/' |
    # Replace (2 years, 5 months) with (2 years)
    sed -Ee 's/(^[^)]*), [[:digit:]]+ .*months?\)/\1)/' |
    # Shorten time
    sed -Ee 's/ seconds?\)/s\)/' |
    sed -Ee 's/ minutes?\)/m\)/' |
    sed -Ee 's/ hours?\)/h\)/' |
    sed -Ee 's/ days?\)/d\)/' |
    sed -Ee 's/ weeks?\)/w\)/' |
    sed -Ee 's/ months?\)/M\)/' |
    # Shorten names
    sed -Ee 's/<Andrew Burgess>/<me>/' |
    sed -Ee 's/<([^ >]+) [^>]*>/<\1>/' |
    # Line columns up based on } delimiter
    column -s '}' -t
}

git_page_maybe() {
    # Page only if we're asked to.
    if [ -n "${GIT_NO_PAGER}" ]; then
        cat
    else
        # Page only if needed.
        less --quit-if-one-screen --no-init --RAW-CONTROL-CHARS --chop-long-lines
    fi
}

# # Atuin
eval "$(atuin init zsh)"

# # Mise
eval "$(/usr/bin/mise activate zsh)"

# # Zoxide
eval "$(zoxide init --cmd cd zsh)"
