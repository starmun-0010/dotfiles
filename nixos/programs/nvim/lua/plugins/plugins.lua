return {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        "numToStr/Comment.nvim",
        opts = {},
        config = function()
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
    { -- Useful plugin to show you pending keybinds.
        "folke/which-key.nvim",
        event = "VimEnter", -- Sets the loading event to 'VimEnter'
        config = function() -- This is the function that runs, AFTER loading
            require("which-key").setup()

            -- Document existing key chains
            require("which-key").add({
                { "<leader>c", group = "[C]ode" },
                { "<leader>c_", hidden = true },
                { "<leader>d", group = "[D]ocument" },
                { "<leader>d_", hidden = true },
                { "<leader>h", group = "Git [H]unk" },
                { "<leader>h_", hidden = true },
                { "<leader>r", group = "[R]ename" },
                { "<leader>r_", hidden = true },
                { "<leader>s", group = "[S]earch" },
                { "<leader>s_", hidden = true },
                { "<leader>t", group = "[T]oggle" },
                { "<leader>t_", hidden = true },
                { "<leader>w", group = "[W]orkspace" },
                { "<leader>w_", hidden = true },
            })
            -- visual mode
            require("which-key").add({
                { "<leader>h", desc = "Git [H]unk", mode = "v" },
            })
        end,
    },
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },
    {
        "stevearc/oil.nvim",
        opts = {},
        config = function()
            require("oil").setup({})
            vim.keymap.set("n", "<leader>_", "<CMD>Oil<CR>", { desc = "Open parent directory" })
            vim.keymap.set("n", "<leader>-", require("oil").toggle_float, { desc = "Open parent directory" })
        end,
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
}
