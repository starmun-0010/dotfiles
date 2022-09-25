local Module = {}
Module.setup = function()
    local extensions = require('telescope').extensions
    local builtins = require('telescope.builtin')
    local bufopts = { silent = true }
    bufopts.desc = 'Find File'
    bufopts.callback = builtins.find_files
    vim.api.nvim_set_keymap('n', '<Leader>sf', '', bufopts)

    bufopts.desc = 'Search Live '
    bufopts.callback = builtins.live_grep
    vim.api.nvim_set_keymap('n', '<Leader>sl', '', bufopts)

    bufopts.desc = 'Search Buffers'
    bufopts.callback = builtins.buffers
    vim.api.nvim_set_keymap('n', '<Leader>sb', '', bufopts)

    bufopts.desc = 'Search Help Tags'
    bufopts.callback = builtins.help_tags
    vim.api.nvim_set_keymap('n', '<Leader>sht', '', bufopts)

    bufopts.desc = 'Search Under Cursor'
    bufopts.callback = builtins.grep_string
    vim.api.nvim_set_keymap('n', '<Leader>suc', '', bufopts)

    bufopts.desc = 'Search Closed Files'
    bufopts.callback = builtins.oldfiles
    vim.api.nvim_set_keymap('n', '<Leader>scf', '', bufopts)

    bufopts.desc = 'Search NVim Commands'
    bufopts.callback = builtins.commands
    vim.api.nvim_set_keymap('n', '<Leader>scc', '', bufopts)

    bufopts.desc = 'Search C Tags'
    bufopts.callback = builtins.tags
    vim.api.nvim_set_keymap('n', '<Leader>sct', '', bufopts)

    bufopts.desc = 'Search Command History'
    bufopts.callback = builtins.command_history
    vim.api.nvim_set_keymap('n', '<Leader>sch', '', bufopts)

    bufopts.desc = 'Search ->Search History'
    bufopts.callback = builtins.search_history
    vim.api.nvim_set_keymap('n', '<Leader>ssh', '', bufopts)

    bufopts.desc = 'Search Man Pages'
    bufopts.callback = builtins.man_pages
    vim.api.nvim_set_keymap('n', '<Leader>smp', '', bufopts)

    bufopts.desc = 'Search Vim Marks'
    bufopts.callback = builtins.marks
    vim.api.nvim_set_keymap('n', '<Leader>svm', '', bufopts)

    bufopts.desc = 'Search Colorshemes'
    bufopts.callback = builtins.colorshceme
    vim.api.nvim_set_keymap('n', '<Leader>scs', '', bufopts)

    bufopts.desc = 'Search Quick Fix'
    bufopts.callback = builtins.quickfix
    vim.api.nvim_set_keymap('n', '<Leader>sqf', '', bufopts)

    bufopts.desc = 'Search Quick Fix History'
    bufopts.callback = builtins.quickfixhistory
    vim.api.nvim_set_keymap('n', '<Leader>sqfh', '', bufopts)

    bufopts.desc = 'Search Loc List'
    bufopts.callback = builtins.loclist
    vim.api.nvim_set_keymap('n', '<Leader>sll', '', bufopts)

    bufopts.desc = 'Search Jump List'
    bufopts.callback = builtins.jumplist
    vim.api.nvim_set_keymap('n', '<Leader>sjl', '', bufopts)

    bufopts.desc = 'Search Vim Options'
    bufopts.callback = builtins.vim_options
    vim.api.nvim_set_keymap('n', '<Leader>svo', '', bufopts)

    bufopts.desc = 'Search Registers'
    bufopts.callback = builtins.registers
    vim.api.nvim_set_keymap('n', '<Leader>srg', '', bufopts)

    bufopts.desc = 'Auto Commands'
    bufopts.callback = builtins.autocommands
    vim.api.nvim_set_keymap('n', '<Leader>sac', '', bufopts)

    bufopts.desc = 'Search Spell Suggest'
    bufopts.callback = builtins.spell_suggest
    vim.api.nvim_set_keymap('n', '<Leader>sss', '', bufopts)

    bufopts.desc = 'Search keymaps'
    bufopts.callback = builtins.keymaps
    vim.api.nvim_set_keymap('n', '<Leader>skm', '', bufopts)

    bufopts.desc = 'Search Highlights'
    bufopts.callback = builtins.hightlights
    vim.api.nvim_set_keymap('n', '<Leader>shi', '', bufopts)

    bufopts.desc = 'Search Current Buffer (Fuzzy)'
    bufopts.callback = builtins.current_buffer_fuzzy_find
    vim.api.nvim_set_keymap('n', '<Leader>scb', '', bufopts)

    bufopts.desc = 'Search Current Buffer Tags'
    bufopts.callback = builtins.current_buffer_tags
    vim.api.nvim_set_keymap('n', '<Leader>scbt', '', bufopts)

    bufopts.desc = 'Search Resume'
    bufopts.callback = builtins.resume
    vim.api.nvim_set_keymap('n', '<Leader>srs', '', bufopts)

    bufopts.desc = 'Search Pickers'
    bufopts.callback = builtins.pickers
    vim.api.nvim_set_keymap('n', '<Leader>spc', '', bufopts)

    bufopts.desc = 'Search LSP References'
    bufopts.callback = builtins.lsp_references
    vim.api.nvim_set_keymap('n', '<Leader>slr', '', bufopts)

    bufopts.desc = 'Search LSP Incoming Calls'
    bufopts.callback = builtins.lsp_incoming_calls
    vim.api.nvim_set_keymap('n', '<Leader>slic', '', bufopts)

    bufopts.desc = 'Search LSP Outgoing Calls'
    bufopts.callback = builtins.lsp_outgoing_calls
    vim.api.nvim_set_keymap('n', '<Leader>scbt', '', bufopts)

    bufopts.desc = 'Search LSP Document Symbols'
    bufopts.callback = builtins.lsp_document_symbols
    vim.api.nvim_set_keymap('n', '<Leader>slds', '', bufopts)

    bufopts.desc = 'Search LSP Workspace Symbols'
    bufopts.callback = builtins.lsp_workspace_symbols
    vim.api.nvim_set_keymap('n', '<Leader>slws', '', bufopts)

    bufopts.desc = 'Search LSP Dynamic Workspace Symbols'
    bufopts.callback = builtins.lsp_dynamic_workspace_symbols
    vim.api.nvim_set_keymap('n', '<Leader>sldws', '', bufopts)

    bufopts.desc = 'Search Diagnostics'
    bufopts.callback = builtins.diagnostics
    vim.api.nvim_set_keymap('n', '<Leader>sdgcs', '', bufopts)

    bufopts.desc = 'Search LSP Implementations'
    bufopts.callback = builtins.lsp_implementations
    vim.api.nvim_set_keymap('n', '<Leader>sli', '', bufopts)

    bufopts.desc = 'Search LSP Definitions'
    bufopts.callback = builtins.definitions
    vim.api.nvim_set_keymap('n', '<Leader>sdf', '', bufopts)

    bufopts.desc = 'Search LSP Type Definitions'
    bufopts.callback = builtins.lsp_type_definitions
    vim.api.nvim_set_keymap('n', '<Leader>sltd', '', bufopts)

    bufopts.desc = 'Search Git Commits'
    bufopts.callback = builtins.git_commits
    vim.api.nvim_set_keymap('n', '<Leader>sgc', '', bufopts)

    bufopts.desc = 'Search Git Buffer Commits'
    bufopts.callback = builtins.git_bcommits
    vim.api.nvim_set_keymap('n', '<Leader>sgbc', '', bufopts)

    bufopts.desc = 'Search Git Branches'
    bufopts.callback = builtins.git_branches
    vim.api.nvim_set_keymap('n', '<Leader>sgb', '', bufopts)

    bufopts.desc = 'Search Git Status'
    bufopts.callback = builtins.git_status
    vim.api.nvim_set_keymap('n', '<Leader>sgss', '', bufopts)

    bufopts.desc = 'Search Git Stash'
    bufopts.callback = builtins.git_stash
    vim.api.nvim_set_keymap('n', '<Leader>sgst', '', bufopts)

    bufopts.desc = 'Search Treesitter'
    bufopts.callback = builtins.treesitter
    vim.api.nvim_set_keymap('n', '<Leader>sts', '', bufopts)

    bufopts.desc = 'Search Telescope Planets'
    bufopts.callback = builtins.planets
    vim.api.nvim_set_keymap('n', '<Leader>stpts', '', bufopts)

    bufopts.desc = 'Search Telescope Builtin Pickers'
    bufopts.callback = builtins.builtin
    vim.api.nvim_set_keymap('n', '<Leader>stbp', '', bufopts)

    bufopts.desc = 'Search Lua Modules'
    bufopts.callback = builtins.reloader
    vim.api.nvim_set_keymap('n', '<Leader>slm', '', bufopts)

    bufopts.desc = 'Search Symbols'
    bufopts.callback = builtins.reloader
    vim.api.nvim_set_keymap('n', '<Leader>ssm', '', bufopts)

    bufopts.desc = 'Search Symbols'
    bufopts.callback = extensions.file_browser.file_browser
    vim.api.nvim_set_keymap('n', '<Leader>sfb', '', bufopts)

    bufopts.desc = 'Search Symbols'
    bufopts.callback = extensions.file_browser.file_browser
    vim.api.nvim_set_keymap('n', '<Leader>sfb',
        'Telescope find_files cwd=~/.config/nvim/ search_dirs=Ultisnips,lua,viml,init.vim ',
        bufopts)
end
return Module
