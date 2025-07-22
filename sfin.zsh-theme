# Based on robbyrussels theme
# name: sfin
# changed some symbols and added fullpath

PROMPT="%(?:%{$fg_bold[green]%}%1{%} :%{$fg_bold[red]%}%1{%} ) %{$fg[cyan]%}%~%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="on %{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
