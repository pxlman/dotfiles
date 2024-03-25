local g = vim.g
local c = vim.cmd
-- local map = vim.keymap.set
function map(mode,key,cmd,descr)
    vim.keymap.set(mode,key,cmd, {desc = descr,silent = true})
end
--[[ Hints 
<Enter> = <CR>
<A-..> = Alt + ..
<M-..> = Alt + ..
<T-..> = Meta + ..
% means file path without extension
%< means file path with extension
C-v vsplit in nvimtree
C-] root to parent 
]]
--
-- Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- [[ Main bindings ]]
-- Exclusive moving (Helpful at wrapped lines)
map('', 'j', "gj", "Moving down")
map('', 'k', "gk", "Moving up")
map('', '<Down>', "gj", "Moving down")
map('', '<Up>', "gk", "Moving up")
-- Fast normal
map('i', 'jk', "<ESC>", "Go to normal mode")
-- Moving in insert
map("i","<A-l>","<Right>", "To right while typing")
map("i","<A-h>","<Left>", "To left while typing")
map("i","<A-k>","<Up>", "To up while typing")
map("i","<A-j>","<Down>", "To down while typing")
-- Fast quit
map("n","<Leader>q",":q<CR>", "[Q]uit Nvim")
-- Start and end of line in insert and normal and visual
map("","<CR>","$", "Line End")
map("i","<A-CR>","<ESC>$a", "Line End")
map("","<S-CR>","^", "Line Start")
map("i","<A-S-CR>","<ESC>^i", "Line Start")
-- 
-- [[ Plugins bindings ]]
-- Move line
map("n","<A-j>",":MoveLine 1<CR>", "Lines down")
map("n","<A-k>",":MoveLine -1<CR>", "Line up")
-- Move Blocks up and down
map("v","<A-k>",":MoveBlock -1<CR>", "Blocks up")
map("v","<A-j>",":MoveBlock 1<CR>", "Blocks down")
-- Nvim Tree
map('n','<Leader>e',':NvimTreeToggle<CR>', "File [E]xplorer")
-- Switch between windows
map('n','<Leader>w','<C-w>', "[W]indow S[W]itch")
