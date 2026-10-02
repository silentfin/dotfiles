# remove startup message
set fish_greeting

# abbreviations
abbr -a so "source .venv/bin/activate.fish"
abbr -a lt --set-cursor "eza --tree --icons --level=2%"
abbr -a l "ls"
abbr -a sl "ls"
abbr -a g "git"
abbr -a ga "git add ."
abbr -a gc --set-cursor 'git commit -m "%"'
abbr -a efish "nvim ~/.config/fish/config.fish"
abbr -a eniri "nvim ~/.config/niri/config.kdl"
abbr -a reload "source ~/.config/fish/config.fish"
abbr -a 1d ".."
abbr -a 2d "../.."
abbr -a 3d "../../.."
abbr -a 4d "../../../.."
abbr -a 5d "../../../../.."
abbr -a yt --set-cursor 'yt-dlp "%"'
abbr -a -p anywhere G "| rg"

# aliases
alias c "clear"
alias cp "cp -iv"
alias mv "mv -iv"
alias rm "rm -iv"
alias mkdir "mkdir -p"
# alias g "git"
alias p "python3"
alias python "python3"
# alias so "source .venv/bin/activate"
alias n "nvim"
alias q "exit"
alias code "codium"
alias zed "zeditor"
alias cd "z"
alias h "history"
alias hs "history | rg"
alias ff "fastfetch"
alias cat "bat"
alias less "bat --style=auto --paging=always"
alias ls "eza --icons --group-directories-first"
alias ll "eza -lah --icons --git --group-directories-first"
alias la "eza -a --icons --group-directories-first"
alias tldrf "tldr --list | fzf --preview 'tldr --color always {}' --preview-window=bottom:70%"
alias af "alias | fzf"
alias envf "env | sort | fzf --preview 'echo {}' --preview-window down:4:wrap"


# Search all packages
alias yays "yay -Slq | fzf --multi --preview 'yay -Si {} | bat --color=always --style=numbers --language=yaml' --preview-window=bottom:60%:wrap | xargs -ro yay -S"
# Search installed packages
alias yayf "yay -Qq | fzf --preview 'yay -Qi {} | bat --color=always --style=numbers --language=yaml' --preview-window=bottom:60%:wrap | xargs -ro pactree -c -r"
# Remove installed packages
alias yayr "yay -Qq | fzf --multi --preview 'yay -Qi {} | bat --color=always --style=numbers --language=yaml' --preview-window=bottom:60%:wrap | xargs -ro yay -Rns"
# Remove orphans
alias orphans 'sudo pacman -Rns $(pacman -Qqdt)'

# copy file contents
function cpf --description "copy file contents"
    bat $argv | wl-copy
end

# create a directory and move inside it
function mkcd --description "mkdir and cd"
    mkdir -p $argv[1] && cd $argv[1]
end

# start at start...?
starship init fish | source
zoxide init fish | source

source $HOME/.config/fish/env.fish
