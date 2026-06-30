if status is-login
    bass source ~/.profile
end

if status is-interactive
    set -g fish_key_bindings fish_vi_key_bindings

    alias eza='eza --header --icons --group-directories-first --smart-group --extended --hyperlink'
    alias lt='eza --tree'
    alias ls='eza'
    alias la='ls --almost-all'
    alias ll='la --long --git'

    alias mv='mv --interactive --verbose'
    alias cp='cp --interactive --verbose'

    fzf --fish | source
end
