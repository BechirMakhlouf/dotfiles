if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# nerdfetch

export EDITOR=nvim
export VISUAL=nvim
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_QPA_PLATFORM=wayland
export _JAVA_AWT_WM_NONREPARENTING=1 # make some java applications run

export FZF_DEFAULT_COMMAND='fd --hidden --exclude="node_modules|.git|.next|.cache|.local|.mozilla|cache|.bun"'

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

FILES_TO_IGNORE_GLOB="node_modules|.git|.next|.github|target|.yarn"
alias ls="exa -ahF --icons --group-directories-first"
alias ll="exa -lahF --icons --no-permissions --no-time --no-filesize --no-user --group-directories-first"
alias lt="exa -ahF --icons --no-permissions --no-time --no-filesize  --no-user --group-directories-first --tree --level 2 --ignore-glob='$FILES_TO_IGNORE_GLOB'"
alias ltt="exa -ahF --icons --no-permissions --no-time --no-filesize  --no-user --group-directories-first --tree --ignore-glob='$FILES_TO_IGNORE_GLOB'"

# alias cd="z"
alias f="yazi"
alias cat="bat"
alias neofetch="fastfetch"

alias copy="wl-copy"
alias paste="wl-paste"

# git aliases
alias gitc="git add . && git commit -m"
alias gitp="git push origin main"
alias gitl="git log --oneline"
alias gits="git status"
alias gitd="git diff"

alias gensecret="node -e \"console.log(require('crypto').randomBytes(32).toString('hex'))\""

alias fk="fuck" # alias npm="pnpm"
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

# todoist
alias todo="todoist-cli"

# cliphist clipboard history
alias clipboard="cliphist list | fzf | cliphist decode | wl-copy"
# ATUIN
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"

bindkey '^r' _atuin_search_widget

# maven stuff
# mvn-java-simple="mvn archetype:generate -DgroupId=com.example -DartifactId=tp-1 -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false"

# depends on terminal mode
bindkey '^[[A' _atuin_search_widget
bindkey '^[OA' _atuin_search_widget

# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export ENHANCD_FILTER="fzf --height 40%:fzy"
# eval "$(zoxide init zsh)"

# export PATH=$PATH:/opt/glassfish6/bin
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH=$PATH:/home/copernicus/.local/bin:/home/copernicus/.cargo/bin:/home/copernicus/.ghcup/bin

# oh my posh
# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/tokyonight_storm.json)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
