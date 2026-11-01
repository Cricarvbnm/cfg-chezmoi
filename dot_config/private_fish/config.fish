if status is-interactive
    set -g fish_key_bindings fish_vi_key_bindings

    alias eza='eza --header --icons --group-directories-first --smart-group --extended --hyperlink=auto'
    alias lt='eza --tree'
    alias ls='eza'
    alias la='ls --almost-all'
    alias ll='la --long --git'

    alias mv='mv --interactive --verbose'
    alias cp='cp --interactive --verbose'
    alias rm='rm --verbose'

    fzf --fish | source
end
