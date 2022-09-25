local Module = {}
Module.setup = function(bufnr)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true }

    bufopts.desc = 'Go to Declaration'
    bufopts.callback = vim.lsp.buf.declaration
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>gD', '', bufopts)

    bufopts.desc = 'Go to Definition'
    bufopts.callback = vim.lsp.buf.definition
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>gd', '', bufopts)

    bufopts.desc = 'Hover'
    bufopts.callback = vim.lsp.buf.hover
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>h', '', bufopts)

    bufopts.desc = 'Go to Implementation'
    bufopts.callback = vim.lsp.buf.implementation
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>gi', '', bufopts)

    bufopts.desc = 'Signature Help'
    bufopts.callback = vim.lsp.buf.signature_help
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>sh', '', bufopts)

    bufopts.desc = 'Add Workspace Folder'
    bufopts.callback = vim.lsp.buf.add_workspace_folder
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>awf', '', bufopts)

    bufopts.desc = 'Remove Workspace Folder'
    bufopts.callback = vim.lsp.buf.remove_workspace_folder
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>rwf', '', bufopts)

    bufopts.desc = 'List Workspace Folders'
    bufopts.callback = function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lwf', '', bufopts)

    bufopts.desc = 'Type Definition'
    bufopts.callback = vim.lsp.buf.type_definition
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>td', '', bufopts)

    bufopts.desc = 'Rename'
    bufopts.callback = vim.lsp.buf.rename
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>r', '', bufopts)

    bufopts.desc = 'Code Action'
    bufopts.callback = vim.lsp.buf.code_action
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ca', '', bufopts)

    bufopts.desc = 'Go to References'
    bufopts.callback = vim.lsp.buf.references
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>gr', '', bufopts)

    bufopts.desc = 'Format File'
    bufopts.callback = vim.lsp.buf.formatting
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ff', '', bufopts)

    bufopts.desc = 'Code Lens'
    bufopts.callback = vim.lsp.codelens.run
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>cl', '', bufopts)
end
return Module
