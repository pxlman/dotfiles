local o = vim.o
local g = vim.g
o.lsp = true -- automatic indeting for LSP
o.ignorecase = true -- Ignore case while tabbing in the command line
o.splitright = true -- New window will put right to the current window
o.expandtab = true
-- Lines Shape
o.relativenumber = true
o.wrap = true -- To make line breaked
o.cursorline = true -- The dark line at the cursor line
-- Indentings
o.autoindent = true -- auto indent when new line is there
o.smarttab = true -- Use shift width when <Tab>
o.shiftwidth = 2 -- Tab width spaces
