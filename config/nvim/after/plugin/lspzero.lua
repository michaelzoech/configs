local lsp = require('lsp-zero').preset({})

lsp.ensure_installed({
  -- Needs shellcheck installed
  'bashls',
  'elixirls',
  'gopls',
  'lua_ls',
  'pylsp',
  -- Needs vale installed
  'vale_ls',
})

lsp.on_attach(function(_client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("i", "<M-CR>", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<M-CR>", vim.lsp.buf.code_action, bufopts)
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
