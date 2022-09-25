local Module = {}
Module.on_attach = function(bufnr)

    local signature_config = {
        bind = true,
        wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
        floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

        floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
        -- will set to true when fully tested, set to false will use whichever side has more space
        -- this setting will be helpful if you do not want the PUM and floating win overlap

        floating_window_off_x = 1, -- adjust float windows x position.
        floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
        --transparency = 80, -- disabled by default, allow floating win transparent value 1~100
        select_signature_key = '<M-n>' -- cycle to next signature, e.g. '<M-n>' function overloading
    }
    require "lsp_signature".on_attach(signature_config, bufnr) -- Note: add in lsp client on-attach
end
Module.setup = function(use)

    use {
        'ray-x/lsp_signature.nvim'
    }
end
return Module
