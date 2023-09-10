require('other-nvim').setup({
  mappings = {
    "golang",
    -- Elixir
    {
      pattern = '/lib/(.*)/(.*).ex$',
      target = '/test/%1/%2_test.exs',
      context = 'test',
    },
    {
      pattern = '/test/(.*)/(.*)_test.exs$',
      target = '/lib/%1/%2.ex',
      context = 'module',
    },
    {
      pattern = '/lib/(.*).ex$',
      target = '/test/%1_test.exs',
      context = 'test',
    },
    {
      pattern = '/test/(.*)_test.exs$',
      target = '/lib/%1.ex',
      context = 'module',
    },
  },
})

vim.api.nvim_set_keymap("n", "<leader>hh", "<cmd>:Other<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>hs", "<cmd>:OtherSplit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>hv", "<cmd>:OtherVSplit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>hc", "<cmd>:OtherClear<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ht", "<cmd>:Other test<CR>", { noremap = true, silent = true })
