local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
    spec = {
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function () 
                local configs = require("nvim-treesitter.configs")
                configs.setup({
                    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "arduino", "comment", "css", "cuda", "dockerfile", "go", "html", "javascript", "jsonc", "make", "python", "rust", "sql", "typescript" },
                    highlight = { enable = true },
                    indent = { enable = true },  
                })
            end
        },
        { "tpope/vim-repeat" },
        { "tpope/vim-unimpaired" },
        { "tpope/vim-fugitive" },
        { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
        { "numToStr/Comment.nvim", opts = {} },
        { "lewis6991/gitsigns.nvim", opts = {} },
        { "nvim-lualine/lualine.nvim", opts = { options = { icons_enabled = false } } },
        { "kylechui/nvim-surround", version = "*", event = "VeryLazy", opts = {} },
        {
            "stevearc/oil.nvim",
            opts = {
                watch_for_changes = true,
                keymaps = { ["gq"] = "actions.close" }
            }
        },
        {
            "ellisonleao/gruvbox.nvim",
            opts = {
                bold = false,
                italic = { strings = false },
                contrast = "hard"
            }
        },
        {
            "navarasu/onedark.nvim",
            opts = {
                style = "warmer"
            }
        },
        {
            "goolord/alpha-nvim",
            config = function ()
                local alpha = require("alpha")
                local startify = require("alpha.themes.startify")
                startify.nvim_web_devicons.enabled = false
                alpha.setup(startify.config)
            end
        },
    },
    rocks = { enabled = false }
})


vim.keymap.set("", "<C-LEFT>", "<C-w>h", { noremap = true })
vim.keymap.set("", "<C-DOWN>", "<C-w>j", { noremap = true })
vim.keymap.set("", "<C-UP>", "<C-w>k", { noremap = true })
vim.keymap.set("", "<C-RIGHT>", "<C-w>l", { noremap = true })


vim.cmd("colorscheme onedark")


vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })


vim.opt.number = true

vim.opt.colorcolumn = "80"

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.clipboard:append("unnamedplus")

vim.opt.wrap = false

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.ruler = false

vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.opt.fillchars = {eob = " "}
