autoload -Uz compinit 
compinit
autoload -Uz colors && colors
eval "$(dircolors)"

setopt HIST_IGNORE_DUPS

export EDITOR="nvim"
export LANG="en_US.UTF-8"

zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}:ma=42;30"

# Case-insensitive + hyphen-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

# Colorful kill completion
#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

#opens the current command in neovim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# History search with up/down arrows
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search      # Up arrow
bindkey '^[[B' down-line-or-beginning-search    # Down arrow

#bindings
bindkey '^[[H'    beginning-of-line       # Home
bindkey '^[[F'    end-of-line             # End
bindkey '^[[3~'   delete-char             # Delete
bindkey '^[[1;5C' forward-word            # Ctrl+Right
bindkey '^[[1;5D' backward-word           # Ctrl+Left
bindkey '^[[3;5~' kill-word               # Ctrl+Delete
bindkey '^H'      backward-kill-word      # Ctrl+Backspace

#prompt
#PROMPT='%n@%m %~ %# '

#history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS


# plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/fzf/key-bindings.zsh

# aliases
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias python="python3"
alias p="python3"
alias vim="nvim"
alias c="clear"
alias 1d="cd .."  
alias 2d="cd ..;cd .."  
alias 3d="cd ..;cd ..;cd .."  
alias 4d="cd ..;cd ..;cd ..;cd .."  
alias 5d="cd ..;cd ..;cd ..;cd ..;cd .." 
# alias meow="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean"
alias sss="~/sss.sh"
# alias note="nvim ~/cs/notes/$(date +'%Y-%m-%d').md"
alias ac="ani-cli -v"
alias ff="fastfetch"
alias ffa="fastfetch --config ~/.config/fastfetch/old.jsonc"
alias q="exit"
alias code="codium"
alias cd="z"
alias history='fc -l 1'
alias h="history"
alias hs="history | rg"
alias n="nvim"

alias ls='eza --icons --group-directories-first'
alias ll='eza -lah --icons --git --group-directories-first'
alias la='eza -a --icons --group-directories-first'
alias lt='eza --tree --level=2 --icons'
alias l='eza -lah --icons --git'

alias cat='bat --style=auto'
alias less='bat --style=auto --paging=always'

alias matrix='cmatrix -b'
alias pipes='pipes.sh'
alias zshrc='${EDITOR:-nvim} ~/.zshrc'
alias eniri='${EDITOR:-nvim} ~/.config/niri/config.kdl'
alias reload='source ~/.zshrc'

. "$HOME/.cargo/env"

. "$HOME/.local/bin/env"

eval "$(zoxide init zsh)"


# Fuzzy kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  [[ -n "$pid" ]] && echo "$pid" | xargs kill -${1:-9}
}

# fuzzy history search
hf() {
  eval $(history | fzf --tac --no-sort | sed 's/^[ ]*[0-9]*[ ]*//')
}

# fuzzy search aliases
af() {
  alias | fzf | sed 's/=.*//' | xargs -I {} zsh -ic {}
}

# Fuzzy environment variables
fenv() {
  env | sort | fzf --preview 'echo {}' --preview-window down:3:wrap
}

# Backup file with timestamp
backup() {
  cp "$1"{,.backup-$(date +%Y%m%d-%H%M%S)}
}

# notes
note() {
  local note_file=~/cs/notes/$(date +'%Y-%m-%d').md
  local timestamp=$(date +'%H:%M')
  
  # Create file with header if it doesn't exist
  if [ ! -f "$note_file" ]; then
    cat > "$note_file" << EOF
# Notes for $(date +'%A, %B %d, %Y')

---

## $timestamp

EOF
  else
    # File exists, add new timestamp entry
    echo -e "\n## $timestamp\n" >> "$note_file"
  fi
  
  # Open at the end of file
  ${EDITOR:-nvim} + "$note_file"
}


# Preview archive contents before extracting
peek() {
  if [ ! -f "$1" ]; then
    echo "'$1' is not a valid file"
    return 1
  fi
  
  case "$1" in
    *.zip)     unzip -l "$1" ;;
    *.tar.gz)  tar tzf "$1" ;;
    *.tar.bz2) tar tjf "$1" ;;
    *.tar.xz)  tar tJf "$1" ;;
    *.tar)     tar tf "$1" ;;
    *.tgz)     tar tzf "$1" ;;
    *.tbz2)    tar tjf "$1" ;;
    *.7z)      7z l "$1" ;;
    *.rar)     unrar l "$1" ;;
    *.gz)      gzip -l "$1" ;;
    *.bz2)     echo "bz2 file: $1" ;;
    *)         echo "Cannot preview '$1' - unknown format" ;;
  esac
}


# Extract archive to folder named after the archive
extract() {
  if [ ! -f "$1" ]; then
    echo "'$1' is not a valid file"
    return 1
  fi
  
  # Get filename without extension
  local name="${1%.*}"
  
  # Handle double extensions (.tar.gz, .tar.bz2, etc.)
  case "$1" in
    *.tar.gz|*.tar.bz2|*.tar.xz) 
      name="${1%.tar.*}"
      ;;
  esac
  
  # Create extraction directory
  mkdir -p "$name"
  
  echo "Extracting '$1' to '$name/'..."
  
  case "$1" in
    *.tar.bz2)   tar xjf "$1" -C "$name" ;;
    *.tar.gz)    tar xzf "$1" -C "$name" ;;
    *.tar.xz)    tar xJf "$1" -C "$name" ;;
    *.tar)       tar xf "$1" -C "$name" ;;
    *.tbz2)      tar xjf "$1" -C "$name" ;;
    *.tgz)       tar xzf "$1" -C "$name" ;;
    *.bz2)       bunzip2 -c "$1" > "$name/${1%.bz2}" ;;
    *.gz)        gunzip -c "$1" > "$name/${1%.gz}" ;;
    *.zip)       unzip -q "$1" -d "$name" ;;
    *.rar)       unrar x "$1" "$name/" ;;
    *.7z)        7z x "$1" -o"$name" ;;
    *.Z)         uncompress -c "$1" > "$name/${1%.Z}" ;;
    *)           
      echo "'$1' cannot be extracted - unknown format"
      rmdir "$name" 2>/dev/null  # Clean up empty dir
      return 1
      ;;
  esac
  
  echo " Extracted to: $name/"
}

# fuzzy find directories and cd to it 
cdd() {
  if [[ -n "$1" && -d "$1" ]]; then
    cd "$1"
  else
    local dir
    dir=$(fd --type d | fzf --query="$1" --preview 'tree -C {} | head -200')
    [[ -n "$dir" ]] && cd "$dir"
  fi
}


# fuzzy find files and edit them in nvim
fo() {
  if [[ -n "$1" && -f "$1" ]]; then
    ${EDITOR:-nvim} "$1"
  else
    local file
    file=$(fd --type f | fzf --query="$1" --preview 'bat --color=always --style=header,grid --line-range :300 {}')
    [[ -n "$file" ]] && ${EDITOR:-nvim} "$file"
  fi
}

# Fuzzy ripgrep - search CONTENT, open at line 
frg() {
  local file line
  read -r file line <<< $(
    rg --color=always --line-number --no-heading --smart-case "${*:-}" |
    fzf --ansi \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' |
    awk -F: '{print $1, $2}'
  )
  [[ -n "$file" ]] && ${EDITOR:-nvim} "$file" "+${line:-1}"
}

# make directory and cd to it
mkcd() {
  mkdir -p "$1" && cd "$1"
}


eval "$(starship init zsh)"
