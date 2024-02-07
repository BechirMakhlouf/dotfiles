if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# nerdfetch

export EDITOR=nvim
export VISUAL=nvim
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_QPA_PLATFORM=wayland
export _JAVA_AWT_WM_NONREPARENTING=1 # make some java applications run

export FZF_DEFAULT_COMMAND='fd --hidden --exclude "node_modules|.git|.next|.github|.cache|.local|.mozilla"'

# source ~/.zplug/init.zsh
#
# zplug "zsh-users/zsh-history-substring-search"
# zplug "zsh-users/zsh-syntax-highlighting"
# zplug "zsh-users/zsh-autosuggestions"
# zplug "zsh-users/zsh-completions"
# # zplug "jeffreytse/zsh-vi-mode"
# zplug "plugins/git", from:oh-my-zsh
# zplug "plugins/z", from:oh-my-zsh
# zplug "themes/bira", from:oh-my-zsh, as:theme
#
# zplug load

alias szsh="source ~/.zshrc"
alias zshconfig="nvim ~/.zshrc"

# enable vi mode
# bindkey -v 

alias vim="nvim"
alias vi="nvim"
alias v="nvim"

FILES_TO_IGNORE_GLOB="node_modules|.git|.next|.github"
alias ls="exa -ahF --icons --group-directories-first"
alias ll="exa -lahF --icons --group-directories-first"
alias lt="exa -ahF --icons --group-directories-first --tree --level 2 --ignore-glob='$FILES_TO_IGNORE_GLOB'"

# alias cd="z"
alias f="yazi"
alias cat="bat"
alias neofetch="fastfetch"

alias copy="wl-copy"
alias paste="wl-paste"

alias gitc="git add . && git commit -m"
alias gitp="git push origin main"
alias gitl="git log --oneline"
alias gits="git status"
alias gitd="git diff"

alias gensecret="node -e \"console.log(require('crypto').randomBytes(32).toString('hex'))\""

alias fk="fuck"

# alias npm="pnpm"
# alias npx="pnpx"
# alias npmm="/usr/bin/npm"
# alias npxx="/usr/bin/npx"


alias next-npm="/usr/bin/npx create-next-app@latest . --eslint --app --typescript --tailwind --no-src-dir --import-alias @"
alias next-pnpm="/usr/bin/pnpx create-next-app@latest . --eslint --app --typescript --tailwind --no-src-dir --import-alias @"
alias next-bun="/usr/bin/bun x create-next-app@latest . --eslint --app --typescript --tailwind --no-src-dir --import-alias @"

eval "$(sheldon source)"
eval $(thefuck --alias)


alias bunx="bun x"

alias weather="weather-Cli get"

# lunar vim
alias lvim="/home/copernicus/.local/bin/lvim"

# ATUIN
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"

bindkey '^r' _atuin_search_widget

# depends on terminal mode
bindkey '^[[A' _atuin_search_widget
bindkey '^[OA' _atuin_search_widget

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export ENHANCD_FILTER="fzf --height 40%:fzy"
