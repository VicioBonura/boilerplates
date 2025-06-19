#!/bin/bash
# Custom .bashrc for Git Bash (Windows)
# Converted from zsh configuration
# Author: Vincenzo Bonura

# Carica i colori dal modulo esistente
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/scripts/modules"
if [[ -f "$SCRIPT_DIR/colors.sh" ]]; then
    source "$SCRIPT_DIR/colors.sh"
fi

# Funzioni Git Status (convertite da zsh)
git_is_dirty() {
    if git rev-parse --is-inside-work-tree &> /dev/null; then
        # Controlla modifiche non staged (working directory dirty)
        if ! git diff-files --quiet --ignore-submodules 2>/dev/null; then
            echo "*"
            return
        fi
        
        # Controlla modifiche staged (index dirty)
        if ! git diff-index --quiet --cached HEAD --ignore-submodules 2>/dev/null; then
            echo "*"
            return
        fi
        
        # Controlla file untracked
        if [[ -n $(git ls-files --others --exclude-standard 2>/dev/null) ]]; then
            echo "*"
            return
        fi
    fi
}

git_has_stash() {
    if git rev-parse --is-inside-work-tree &> /dev/null; then
        if [[ $(git stash list 2> /dev/null | wc -l) -gt 0 ]]; then
            echo "≡"
        fi
    fi
}

git_ahead_behind() {
    if git rev-parse --is-inside-work-tree &> /dev/null; then
        local curr_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
        local curr_remote=$(git config branch.$curr_branch.remote 2> /dev/null)
        
        if [[ -n "$curr_remote" ]]; then
            local ahead=$(git rev-list --count $curr_branch@{upstream}..HEAD 2> /dev/null)
            local behind=$(git rev-list --count HEAD..$curr_branch@{upstream} 2> /dev/null)
            
            if [[ $ahead -gt 0 ]] && [[ $behind -gt 0 ]]; then
                echo " ↕"
            elif [[ $ahead -gt 0 ]]; then
                echo " ↑"
            elif [[ $behind -gt 0 ]]; then
                echo " ↓"
            fi
        fi
    fi
}

get_git_branch() {
    if git rev-parse --is-inside-work-tree &> /dev/null; then
        git rev-parse --abbrev-ref HEAD 2> /dev/null
    fi
}

# Ottieni ultimi 2 livelli del path
get_short_pwd() {
    local pwd_parts=(${PWD//\// })
    local num_parts=${#pwd_parts[@]}
    
    if [[ $num_parts -le 2 ]]; then
        basename "$PWD"
    else
        echo "${pwd_parts[$((num_parts-2))]}/${pwd_parts[$((num_parts-1))]}"
    fi
}

# Funzione per costruire il prompt
build_prompt() {
    local last_status=$?
    local short_pwd=$(get_short_pwd)
    local git_branch=$(get_git_branch)
    local git_dirty=$(git_is_dirty)
    local git_stash=$(git_has_stash)
    local git_sync=$(git_ahead_behind)
    
    # Simboli
    local lightning="★"
    local stash_symbol="≡"
    local prompt_char="❯"
    
    # Prompt base con path (cyan)
    PS1="\[\e[0;36m\]${short_pwd}\[\e[0m\]"
    
    # Aggiungi info git se in repo
    if [[ -n "$git_branch" ]]; then
        # Branch name (giallo)
        PS1+="\[\e[0;93m\] ${git_branch}\[\e[0m\]"
        
        # Dirty status (rosso)
        if [[ -n "$git_dirty" ]]; then
            PS1+="\[\e[0;31m\] ${lightning}\[\e[0m\]"
        fi
        
        # Stash status (cyan)
        if [[ -n "$git_stash" ]]; then
            PS1+="\[\e[0;36m\] ${stash_symbol}\[\e[0m\]"
        fi
        
        # Sync status (magenta)
        if [[ -n "$git_sync" ]]; then
            PS1+="\[\e[0;95m\]${git_sync}\[\e[0m\]"
        fi
    fi
    
    # Prompt char - verde se successo, rosso se errore
    if [[ $last_status -eq 0 ]]; then
        PS1+="\[\e[0;32m\] ${prompt_char}\[\e[0m\] "
    else
        PS1+="\[\e[0;31m\] ${prompt_char}\[\e[0m\] "
    fi
}

# Imposta il prompt
PROMPT_COMMAND=build_prompt

# Opzioni bash
set -o vi  # Usa keybinding vi (cambia in emacs se preferisci)
shopt -s histappend
shopt -s checkwinsize

# History
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth

# Aliases essenziali
alias ll='ls -l'
alias la='ls -la'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --all'

# Completion per Git Bash (se disponibile)
if [[ -f /usr/share/bash-completion/completions/git ]]; then
    source /usr/share/bash-completion/completions/git
fi

# Messaggio di benvenuto
if [[ -n "${BASH_VERSION:-}" ]]; then
    echo -e "\n${GREEN}✔ Configurazione bash personalizzata caricata!${NC}"
    echo -e "${DARKGRAY}  Git Bash ready - Prompt personalizzato attivo${NC}\n"
fi 

source ./shell.sh