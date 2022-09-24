local Module = {}
Module.setup = function(bufnr)
    print('dsfsdafsd')
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', '<Leader>gnh', function()
        if vim.wo.diff then return '<Leader>gnh' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
    end, { expr = true, desc = "Next Hunk" })

    map('n', '<Leader>gph', function()
        if vim.wo.diff then return '<Leader>gph' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
    end, { expr = true, desc = "Previous Hunk" })

    -- Actions
    map({ 'n', 'v' }, '<Leader>gsh', ':Gitsigns stage_hunk<CR>', { desc = "Stage Hunk" })
    map({ 'n', 'v' }, '<Leader>grh', ':Gitsigns reset_hunk<CR>', { desc = "Reset Hunk" })
    map('n', '<Leader>gsb', gs.stage_buffer, { desc = "Stage Buffer" })
    map('n', '<Leader>gusb', gs.undo_stage_hunk, { desc = "Undo Stage Buffer" })
    map('n', '<Leader>grb', gs.reset_buffer, { desc = "Reset Buffer" })
    map('n', '<Leader>gph', gs.preview_hunk, { desc = "Preview Hunk" })
    map('n', '<Leader>gbl', function() gs.blame_line { full = true } end, { desc = "Blame Line" })
    map('n', '<Leader>gtclb', gs.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
    map('n', '<Leader>gdt', gs.diffthis, { desc = "Diff This" })
    map('n', '<Leader>gDt', function() gs.diffthis('~') end, { desc = "Diff This" })
    map('n', '<Leader>gtd', gs.toggle_deleted, { desc = "Toggle Delete" })

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {desc="Select Hunk"})
end
return Module
