if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Add greeting
function fish_greeting
    neofetch 
end

fish_vi_key_bindings

function fish_user_key_bindings
    bind -M insert -m default jj backward-char force-repaint
end

set EDITOR 'nvim'
set VISUAL 'nvim'

