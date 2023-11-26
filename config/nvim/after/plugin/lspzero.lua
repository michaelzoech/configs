local lsp = require('lsp-zero').preset({})

lsp.ensure_installed({
  -- Needs shellcheck installed
  'bashls',
  'elixirls',
  'gopls',
  'lua_ls',
  -- Needs vale installed
  'vale_ls',
})

lsp.on_attach(function(_client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({ buffer = bufnr })
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

require('lspconfig').elixirls.setup({
  settings = {
    elixirLS = {
      enableTestLenses = true,
    }
  }
})

require('lspconfig').vale_ls.setup({})

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = {
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<C-Space>'] = cmp.mapping.complete(),
  }
})

local format_group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { "*.lua", "*.ex", "*.exs" },
  callback = function()
    vim.lsp.buf.format()
  end,
  group = format_group
})
