function map(mode,key,cmd,descr)
    vim.keymap.set(mode,key,cmd,{desc = descr,silent = true})
end
return {
    -- Gaze deeply into unknown regions using the power of the moon.
    "nvim-telescope/telescope.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        -- Telescope
        local telescope = require('telescope.builtin')
        map('n', '<leader>ff', telescope.find_files, "")
        map('n', '<leader>fg', telescope.live_grep, "")
        map('n', '<leader>fb', telescope.buffers, "")
        map('n', '<leader>fh', telescope.help_tags, "")
    end,
}
