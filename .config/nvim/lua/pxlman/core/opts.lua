local o = vim.o
local g = vim.g


o.relativenumber = true

o.autoindent = true -- auto indent when new line is there
o.lsp = true -- automatic indeting for LSP

o.smarttab = true -- Use shift width when <Tab>
o.shiftwidth = 4 -- Tab width spaces
-- To make line breaked kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
o.wrap = true
g.smoothscroll = true 
-- Ignore case while tabbing in the command line
g.ignorecase = true
-- The dark line at the cursor line
o.cursorline = true
-- New window will put right to the current window
o.splitright = true


