require('nvim-tree').setup({
    disable_netrw = true,
    hijack_cursor = true,
    hijack_netrw = true,
    hijack_cursor = true,
    update_cwd = true,
    sync_root_with_cwd=true,
    view = {
        number = true,
        relativenumber = true,
    },
    renderer = {
        icons = {
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
    },
    filters = {
        custom = { '.git' },
    },
})
