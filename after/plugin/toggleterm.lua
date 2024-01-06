local status_ok, toggleterm = pcall(require, 'toggleterm')
if not status_ok then
    return
end

toggleterm.setup({
    size = 20,
    open_mapping = [[<C-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mapping = true,
    persist_size = true,
    direction = 'float',
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = 'curved',
        winblend = 0,
        highlights = {
            border = 'Normal',
            background = 'Normal',
        },
    },
})

function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Set custom terminal
local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = 'lazygit', hidden = true })
local stack_ghci = Terminal:new({ cmd = 'stack ghci', hidden = true })
local btm = Terminal:new({ cmd = 'btm', hidden = true })

function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

function _STACK_GHCI_TOGGLE()
    stack_ghci:toggle()
end

function _BTM_TOGGLE()
    btm:toggle()
end

vim.keymap.set('n', [[<M-t>f]], '<cmd>execute v:count . "ToggleTerm direction=float"<CR>', { desc = 'Toggle to Terminal (float)' })
vim.keymap.set('n', [[<M-t>h]], '<cmd>execute v:count . "ToggleTerm direction=horizontal"<CR>', { desc = 'Toggle to Terminal (horizontal)' })
vim.keymap.set('n', [[<M-t>v]], '<cmd>execute v:count . "ToggleTerm direction=vertical"<CR>', { desc = 'Toggle to Terminal (vertical)' })


vim.keymap.set('n', [[<M-t>g]], '<cmd>lua _LAZYGIT_TOGGLE()<CR>', { silent = true, desc = 'Toggle to Lazy Git' })
vim.keymap.set('n', [[<M-t>s]], '<cmd>lua _STACK_GHCI_TOGGLE()<CR>', { silent = true, desc = 'Toggle to Stack gchi' })
vim.keymap.set('n', [[<M-t>t]], '<cmd>lua _BTM_TOGGLE()<CR>', { silent = true, desc = 'Toggle to btm' })
