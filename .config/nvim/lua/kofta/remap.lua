local g = vim.g
local c = vim.cmd

local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

-- <Enter> = <CR>
-- <A-..> = Alt + ..
-- <T-..> = Meta + ..
-- % means file path without extension
-- %< means file path with extension
-- C-v vsplit in nvimtree
-- C-] root to parent
--
--
--
g.mapleader = " "
map("n", "<Leader>e", c.NvimTreeToggle)
map("v", "<C-c>", '"+y')
map("i", "<C-c>", '"+y')
map("n", "<Leader><Leader>", "<C-w>w")
map("n", "<Leader>j", "<C-w>j")
map("n", "<Leader>k", "<C-w>k")
map("n", "<Leader>l", "<C-w>l")
map("n", "<Leader>h", "<C-w>h")
map("i", "<a-[>", "<ESC>I")
map("i", "<A-]>", "<ESC>A")
-- Splitting
map("n", "<Leader>sl", c.vsp)
map("n", "<Leader>sj", c.sp)
map("n", "<Leader>sm", c.MaximizerToggle)

-- Escape
map("i", "jk", "<ESC>")
map("t", "jk", "<C-\\><C-n>")
map("t", "<ESC>", "<C-\\><C-n>")
-- Quit
map("n", "<Leader>q", c.q)

-- hjkl arrows
map("i", "<A-h>", "<Left>")
map("i", "<A-j>", "<Down>")
map("i", "<A-k>", "<Up>")
map("i", "<A-l>", "<Right>")
-- hjkl arrows in term
map("t", "<A-h>", "<Left>")
map("t", "<A-j>", "<Down>")
map("t", "<A-k>", "<Up>")
map("t", "<A-l>", "<Right>")

--vim.keymap.set('n', '<C-c>',)
--
--
--
--
--
--
-- map("n", "<F5>", ":RunCode<CR>")

map("n", "<Leader>db", function()
	require("dapui").toggle()
end) -- toggle dapui style

vim.keymap.set("n", "<leader>dk", function()
	require("dap").continue()
end) -- run or continue a breakpoint
map("n", "<F6>", ":DapStepOver<CR>")
vim.keymap.set("n", "<leader>dx", function()
	require("dap").terminate()
end) -- run or continue a breakpoint
vim.keymap.set("n", "<leader>do", function()
	require("dap").step_over()
end)
vim.keymap.set("n", "<letder>dl", function()
	require("dap").run_last()
end) -- run last breakpoint

vim.keymap.set("n", "<leader>b", function()
	require("dap").toggle_breakpoint()
end) -- toggle a breakpoint
map("n", "<Leader>ds", function()
	require("dapui").open({ reset = true })
end) -- reset dapui sizes
--
--
--
-- Tabs
map("n", "<Leader>tt", ":tabnew<CR>")
map("n", "<Leader><Tab>", ":tabnext<CR>")
map("n", "<Leader>tl", ":tabnext<CR>")
map("n", "<Leader>th", ":tabprevious<CR>")

-- Maximizer
map("n", "<Leader>m", ":MaximizerToggle<CR>")

-- vim.api.nvim_create_autocmd({ "BufWrite" }, {
-- 	pattern = { "*.cpp" },
-- 	command = ":silent !g++ % -o %<",
-- })
--
-- vim.cmd("autocmd filetype cpp nnoremap <silent> <F5> :exec '!%<'<CR>")
--
-- % file
-- %:r  file without ext
-- %:p path to file's folder
-- vim.fn.expand("%") as lua
-- Build
vim.cmd(
	"autocmd filetype cpp nnoremap <silent> <F8> :w <bar> :silent exec '!rm '.shellescape('%:r').'' <bar> exec '!g++ -o '.shellescape('%:r').' '.shellescape('%').' --debug '<CR>"
)
-- RunCode
vim.cmd("autocmd filetype cpp nnoremap <silent> <F7> :w <bar> :TermExec cmd='g++ % -o %< && %:p:r && rm %:p:r' <CR>")
vim.cmd("autocmd filetype sh nnoremap <silent> <F7> :w <bar> :TermExec cmd='chmod +x % && %' <CR>")
