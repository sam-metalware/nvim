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
--vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
--vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 20

vim.opt.colorcolumn = "100"

vim.opt.wrap = true


-- trigger `autoread` when files changes on disk
vim.opt.autoread = true
vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI', 'CursorMoved', 'CursorMovedI'}, {
  pattern = '*',
  command = 'if getcmdwintype() == "" | checktime | endif'
})
-- notification after file change
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  pattern = '*',
  command = 'echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None'
})
