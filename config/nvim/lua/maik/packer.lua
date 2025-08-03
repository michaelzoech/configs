local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use('nvim-treesitter/playground')

  --use('mhartington/oceanic-next')
  use('navarasu/onedark.nvim')
  use { 'santos-gabriel-dario/darcula-solid.nvim',
    requires = 'rktjmp/lush.nvim'
  }

  use('rgroli/other.nvim')

  use('numToStr/Comment.nvim')

  use('sbdchd/neoformat')

  use {
    "folke/trouble.nvim",
    requires = {
      { "nvim-tree/nvim-web-devicons" },
    },
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
