return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "liquid",
            "python",
            "go",
            "bash",
            "c",
            "diff",
            "html",
            "lua",
            "luadoc",
            "markdown",
            "vim",
            "vimdoc",
            "c_sharp",
            "nix",
        },
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = {},
        },
        indent = { enable = true, disable = {} },
    },
    config = function(_, opts)
        require("nvim-treesitter.install").prefer_git = true
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter.configs").setup(opts)

        --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
        --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
}
