# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
      gitfast
      git
      last-working-dir
      common-aliases
      zsh-syntax-highlighting
      zsh-autosuggestions
      zsh-history-substring-search
)

# Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"


# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="${HOME}/.local/bin:${PATH}"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export AWS_CONFIG_FILE=~/.aws/config
export AWS_PROFILE=dev

source ~/.secrets.zsh

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down



# function to open code stuff in nvim:
ov() {
  cd "/Users/edwardphillips/code/ed1001/$1" && nvim
}

# function to open config stuff in nvim:
ovc() {
 "/Users/edwardphillips/.config/$1" && nvim
}

# function to go to code dirs:
cdc() {
  cd "/Users/edwardphillips/code/ed1001/$1"
}

# Function to add autocomplete for a given command and directory
add_autocomplete() {
    local cmd=$1
    local dir=$2

    eval "_autocomplete_${cmd}() {
        local cur=\${COMP_WORDS[COMP_CWORD]}
        local prev=\${COMP_WORDS[COMP_CWORD-1]}
        if [[ \"\$prev\" == \"$cmd\" ]]; then
            COMPREPLY=( \$(compgen -W \"\$(ls $dir)\" -- \$cur) )
        fi
    }"
    complete -F "_autocomplete_${cmd}" $cmd
}

add_autocomplete ov "/Users/edwardphillips/code/ed1001/"
add_autocomplete ovc "/Users/edwardphillips/.config/"
add_autocomplete cdc "/Users/edwardphillips/code/ed1001/"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source /Users/edwardphillips/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"
