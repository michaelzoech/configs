vim.g.neoformat_enabled_markdown = {'prettier'}

local format_group = vim.api.nvim_create_augroup("neoformat", {clear = true})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = {"*.md"},
  callback = function()
    vim.cmd('Neoformat')
  end,
  group = format_group
})

