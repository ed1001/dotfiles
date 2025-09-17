source $HOME/code/ed1001/dotfiles/path-append.sh
source $HOME/code/ed1001/dotfiles/secrets.zsh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
      gitfast
      git
      last-working-dir
      common-aliases
)

export HOMEBREW_NO_ANALYTICS=1

source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)
unalias lt # interferes with localtunnel
unalias "P" # https://github.com/ohmyzsh/ohmyzsh/issues/5243

# load aliases
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"


export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

path_append "$HOME/bin/"
path_append "$HOME/.yarn/bin" before
path_append "$HOME/.config/yarn/global/node_modules/.bin" before
path_append "$HOME/.local/bin" before
path_append "$HOME/scripts"
path_append "/Applications/Docker.app/Contents/Resources/bin/"
path_append "$HOME/.cargo/"

# pnpm
export PNPM_HOME="${HOME}/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


export AWS_CONFIG_FILE=~/.aws/config
export AWS_PROFILE=dev

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn

# cargo
[[ -s "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# custom functions

# function to open code stuff in nvim:
ov() {
  cd "${HOME}/code/ed1001/$1" && nvim
}

# function to open config stuff in nvim:
ovc() {
 "${HOME}/.config/$1" && nvim
}

# function to go to code dirs:
cdc() {
  cd "${HOME}/code/ed1001/$1"
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

add_autocomplete ov "${HOME}/code/ed1001/"
add_autocomplete ovc "${HOME}/.config/"
add_autocomplete cdc "${HOME}/code/ed1001/"

function gswf() {
    git switch $(git branch --list | fzf)
}

function glf() {
    git pull origin $(git branch --list | fzf)
}

function glnrf() {
    git pull --no-rebase origin $(git branch --list | fzf)
}


# fnm
FNM_PATH="/opt/homebrew/opt/fnm/bin"
if [ -d "$FNM_PATH" ]; then
  eval "`fnm env`"
fi

eval "$(fnm env --use-on-cd --shell zsh)"

