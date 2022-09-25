local Module = {}
Module.setup = function()
    vim.keymap.set('i', 'jj', '<Esc>', { remap = true, desc = 'Map jj to Escape' })
    vim.keymap.set( {'i', 'n'} , '<Esc>', '<Esc><cmd>wa<Cr>', {remap =false,
        desc = 'Autosave on switch to Normal mode'
    })
end
return Module
