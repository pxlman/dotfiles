local g = vim.g
local c = vim.cmd
local map = vim.keymap.set
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
g.mapleader = " "
g.maplocalleader = "\\"

-- [[ Main bindings ]]
-- Exclusive moving (Helpful at wrapped lines)
map('', 'j', "gj", {desc = "Moving down"})
map('', 'k', "gk", {desc = "Moving up"})
map('', '<Down>', "gj", {desc = "Moving down"})
map('', '<Up>', "gk", {desc = "Moving up"})
map('i', 'jk', "<ESC>", {desc = "Go to normal mode"})
-- Moving in insert
map("i","<A-l>","<Right>",{desc = "To right while typing"})
map("i","<A-h>","<Left>",{desc = "To left while typing"})
map("i","<A-k>","<Up>",{desc = "To up while typing"})
map("i","<A-j>","<Down>",{desc = "To down while typing"})
-- Fast quit
map("n","<Leader>q",":q<CR>",{desc = "Quit Nvim"})
-- Start and end of line in insert and normal and visual
map("","<A-CR>","$",{desc = "End of line"})
map("i","<A-CR>","<ESC>$a",{desc = "End of line"})
map("","<A-S-CR>","^",{desc = "Start of line"})
map("i","<A-S-CR>","<ESC>^i",{desc = "Start of line"})
-- 
-- [[ Plugins bindings ]]
-- Move line
map("n","<A-j>",":MoveLine 1<CR>",{desc = "Move lines down"})
map("n","<A-k>",":MoveLine -1<CR>",{desc = "Move line up"})
-- Telescope
local telescope = require('telescope.builtin')
map('n', '<leader>ff', telescope.find_files, {})
map('n', '<leader>fg', telescope.live_grep, {})
map('n', '<leader>fb', telescope.buffers, {})
map('n', '<leader>fh', telescope.help_tags, {})
-- Move Blocks up and down
map("v","<A-k>",":MoveBlock -1<CR>",{desc = "Move blocks up"})
map("v","<A-j>",":MoveBlock 1<CR>",{desc = "Move blocks down"})
-- Nvim Tree
map('n','<Leader>e',':NvimTreeToggle<CR>',{desc = "File explorer"})
-- Teminal [[
map('n','<C-\\>',":FloatermToggle scratchy<CR>",{desc = "Show Floating Terminal"})
map('t','<C-\\>',"<C-\\><C-n>:FloatermToggle scratchy<CR>",{desc = "Hide Floating Terminal"})
--c(":FloatermNew --height=0.9 --width=0.9 --wintype=float --name=scratchy --autoclose=2 --silent<CR>")
-- map('n','<F7>',":FloatermNew --autoclose=0 g++ % -o %< && ./%<<CR>",{desc = "Compile c++ files"})
-- ]]

