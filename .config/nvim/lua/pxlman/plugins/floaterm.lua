function map(mode,key,cmd,desc)
    vim.keymap.set(mode,key,cmd,{desc = desc,silent = true})
end
return {
    -- Floating terminal
    "voldikss/vim-floaterm",
    config = function()
        map('n','<C-\\>',":FloatermToggle scratchy<CR>","Show Floating Terminal")
        map('t','<C-\\>',"<C-\\><C-n>:FloatermToggle scratchy<CR>","Hide Floating Terminal")
        map('t','jk',"<C-\\>","Show Floating Terminal")
        -- vim.cmd(":FloatermNew --height=0.9 --width=0.9 --wintype=float --name=scratchy --autoclose=2 --silent<CR>")
        -- map('n','<F7>',":FloatermNew --autoclose=0 g++ % -o %< && ./%<<CR>",{desc = "Compile c++ files"})
        map('n','<F2>',":FloatermNew --autoclose=0 g++ %:p -o /tmp/m <CR>",{desc = "Build C++ files"})
    end
}
