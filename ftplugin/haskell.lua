local ht = require('haskell-tools')
local def_opts = { noremap = true, silent = true, }

ht.start_or_attach {
  tools = { -- haskell-tools options
    hover = {
      -- Whether to disable haskell-tools hover
      -- and use the builtin lsp's default handler
      disable = false,
      -- Set to nil to disable
      border = {
        { '╭', 'FloatBorder' },
        { '─', 'FloatBorder' },
        { '╮', 'FloatBorder' },
        { '│', 'FloatBorder' },
        { '╯', 'FloatBorder' },
        { '─', 'FloatBorder' },
        { '╰', 'FloatBorder' },
        { '│', 'FloatBorder' },
      },
      -- Stylize markdown (the builtin lsp's default behaviour).
      -- Setting this option to false sets the file type to markdown and enables
      -- Treesitter syntax highligting for Haskell snippets
      -- if nvim-treesitter is installed
      stylize_markdown = false,
      -- Whether to automatically switch to the hover window
      auto_focus = false,
    },
  },
  hls = {
    settings = {
        haskell = {
            cabalFormattingProvider = "cabalfmt",
            formattingProvider = "ormolu",
            plugin = {
                importLens = {
                    codeLensOn = false,
                },
            },
        },
    },
    on_attach = function(client, bufnr)
      local opts = vim.tbl_extend('keep', def_opts, { buffer = bufnr, })
      -- haskell-language-server relies heavily on codeLenses,
      -- so auto-refresh (see advanced configuration) is enabled by default
      vim.keymap.set('n', '<leader>ca', vim.lsp.codelens.run, opts)
      vim.keymap.set('n', '<leader>hs', ht.hoogle.hoogle_signature, opts)
      vim.keymap.set('n', '<leader>ea', ht.lsp.buf_eval_all, opts)
      -- default_on_attach(client, bufnr)  -- if defined, see nvim-lspconfig

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

      vim.keymap.set('n', '<leader>dl', '<cmd>Telescope diagnostics<cr>', opts)
      vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev, opts)

      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, opts)
      -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
    end,
  },
}
--
-- Suggested keymaps that do not depend on haskell-language-server
local bufnr = vim.api.nvim_get_current_buf()
-- set buffer = bufnr in ftplugin/haskell.lua
local opts = { noremap = true, silent = true, buffer = bufnr }

-- Toggle a GHCi repl for the current package
vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)

-- Toggle a GHCi repl for the current buffer
vim.keymap.set('n', '<leader>rf', function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, def_opts)

vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)


--      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
--      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
