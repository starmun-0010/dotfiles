local Module = {}
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    ---@diagnostic disable-next-line: missing-parameter
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
local packer_config = {
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end
        }
    }
}

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
local post_init = function(packer)
    if packer_bootstrap then
        packer.sync()
    end
    packer.install()
    packer.compile()
end

Module.setup = function(load_plugins_callback)
    local packer = require('packer')
    local function load_plugins(use)
        use {
            'wbthomason/packer.nvim',
        }
        load_plugins_callback(use)
        post_init(packer)
    end

    packer.startup({ load_plugins, packer_config })
end
return Module
