-- Init NeoVim with Vim config
vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.config/vim/common.vim
]])
