require("trouble").setup({
    icons = false,
    auto_open = false,
    auto_close = true,
})

vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
