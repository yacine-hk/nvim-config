vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true


vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 30
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "0"

vim.o.undofile = true


vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight", {clear = true}),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Quick fix list
vim.keymap.set("n", "<leader>q", "<cmd>copen<CR>zz", {desc = "Open quickfix"})
vim.keymap.set("n", "<leader>Q", "<cmd>cclose<CR>zz", {desc = "Close quickfix"})
vim.keymap.set("n", "<leader>h", "<cmd>cnext<CR>zz", {desc = "Forward quickfix"})
vim.keymap.set("n", "<leader>;", "<cmd>cprev<CR>zz", {desc = "Backward quickfix"})
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", {desc = "Forward list item"})
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", {desc = "Backward list item"})
