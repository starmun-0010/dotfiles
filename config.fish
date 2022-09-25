if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Add greeting
function fish_greeting
    set cow (random choice (cowsay -l | string replace /usr/share/cowsay/cows: "" | string replace "Cow files in" "" | string split -n " "))
    neofetch --ascii (fortune | cowsay -f (echo $cow) -W 30 | string collect --no-trim-newline) | lolcat
end

fish_vi_key_bindings

function fish_user_key_bindings
    bind -M insert -m default jj backward-char force-repaint
end

set EDITOR 'nvim' 
set VISUAL 'nvim'

set -g theme_nerd_fonts yes

