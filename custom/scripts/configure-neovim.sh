#!/bin/bash

set -e 

# configure neovim
mkdir -p ~/.config/nvim/lua/config
cat << EOF > $HOME/.config/nvim/init.lua
require("config.plugins")
require("config.options")
require("config.keymaps")
require("config.lsp")
require("config.cmp")
require("nvim-tree").setup()
require("lualine").setup()
--
EOF

cat << 'EOF' > $HOME/.config/nvim/lua/config/plugins.lua
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

require("lazy").setup({
  -- colors
  { "folke/tokyonight.nvim" },

  -- filetree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- statusbar
  { "nvim-lualine/lualine.nvim" },

  -- lsp & autocompletion
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip"
    }
  }
})
--
EOF

cat << 'EOF' > $HOME/.config/nvim/lua/config/options.lua
vim.opt.wrap = false
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.cmd.colorscheme("style")
--
EOF

cat << 'EOF' > $HOME/.config/nvim/lua/config/keymaps.lua 
vim.g.mapleader = " "

-- NvimTree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- 
EOF

cat << 'EOF' > $HOME/.config/nvim/lua/config/lsp.lua
local lspconfig = require("lspconfig")

-- python lsp
lspconfig.pylsp.setup({
  cmd = { "/home/user/.local/bin/pylsp" }
})

-- c/c++ lsp
lspconfig.clangd.setup {}
--
EOF

cat << 'EOF' > $HOME/.config/nvim/lua/config/cmp.lua
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "nvim_lsp" },
  },
})
--
EOF

echo 'export PATH="$PATH:$HOME/.local/bin"' >> $HOME/.bashrc
echo 'export PATH="$PATH:$HOME/.local/pipx/venvs/python-lsp-server/bin"' >> $HOME/.bashrc

# install with pipx the python lsp server
pipx install 'python-lsp-server[all]'

# style
mkdir -p ~/.config/nvim/colors/
cat << 'EOF' > ~/.config/nvim/colors/style.lua
vim.g.colors_name = "style"

vim.api.nvim_set_hl(0, "Normal",        { fg = "#A0B6DF", bg = "#111D33" })
vim.api.nvim_set_hl(0, "Comment",       { fg = "#808080" })
-- vim.api.nvim_set_hl(0, "Comment",       { fg = "#7092CF" })
vim.api.nvim_set_hl(0, "String",        { fg = "#00FF00" })
-- vim.api.nvim_set_hl(0, "String",        { fg = "#7FFF7F" }) 
vim.api.nvim_set_hl(0, "Number",        { fg = "#FF9000" })
-- vim.api.nvim_set_hl(0, "Number",        { fg = "#E5C07B" })
vim.api.nvim_set_hl(0, "Boolean",       { fg = "#00DFFF" })
vim.api.nvim_set_hl(0, "Keyword",       { fg = "#FF00FF" })
-- vim.api.nvim_set_hl(0, "Keyword",       { fg = "#416DC0" })
vim.api.nvim_set_hl(0, "Function",      { fg = "#FFFF00" })
-- vim.api.nvim_set_hl(0, "Function",      { fg = "#56B6C2" })
vim.api.nvim_set_hl(0, "Type",          { fg = "#5C87D6" }) -- 5C87D6
-- vim.api.nvim_set_hl(0, "Type",          { fg = "#7092CF" })

vim.api.nvim_set_hl(0, "LineNr",        { fg = "#7092CF", bg = "#111D33" })
vim.api.nvim_set_hl(0, "CursorLineNr",  { fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "CursorLine",    { bg = "#1a2944" })
vim.api.nvim_set_hl(0, "Visual",        { bg = "#264F78" })
vim.api.nvim_set_hl(0, "StatusLine",    { fg = "#E6EDF3", bg = "#3D6BB3" })
vim.api.nvim_set_hl(0, "StatusLineNC",  { fg = "#5C87D6", bg = "#111D33" })

vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#FF6C6B" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
  fg = "#1a2944",
  bg = "#E57373",
  underline = false
})

vim.api.nvim_set_hl(0, "DiagnosticWarn",  { fg = "#E5C07B" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", {
  fg = "#1a2944",
  bg = "#F7DC6F",
  underline = false
})

vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#56B6C2" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {
  fg = "#1a2944",
  bg = "#AED9E0",
  underline = false,
})

vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#7F849C" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {
  fg = "#1a2944",
  bg = "#C9CCD4",
  underline = false,
})

vim.api.nvim_set_hl(0, "Search",       { bg = "#3D6BB3", fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "IncSearch",    { bg = "#FFFF00", fg = "#000000" })
vim.api.nvim_set_hl(0, "MatchParen",   { fg = "#FFFFFF", bg = "#3D6BB3" })
EOF
