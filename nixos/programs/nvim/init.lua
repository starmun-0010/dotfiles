vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.have_nerd_font = true

vim.opt.cmdheight = 0

vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.mouse = ""
vim.opt.splitright = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split"

vim.opt.scrolloff = 10

vim.opt.hlsearch = true

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highligh-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ timeout = 500 })
    end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cs",
    callback = function ()
        print("yoooo")
    local disp = vim.lsp.rpc.connect("rospip")
        local command = ''
        vim.lsp.rpc.start({
           name = 'roslynls',
            dispatchers = disp,
           cmd = function ()
               uv.spawn{'dotnet run /src/repos/roslynls.git/main/tcp-wrapper/src/LanguageServer/Microsoft.CodeAnalysis.LanguageServer --logLevel="Trace" --extensionLogDirectory=/tmp'}
            end,
	    root_dir = vim.fs.root(0, function(name, path)
                return name:match('%.sln$') ~= nil
            end)  
        })
    end 
})
require("lazy").setup("plugins")
