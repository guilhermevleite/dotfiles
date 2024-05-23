-- Client telling the server: here's what I can do!
-- This is part of autocomplete, but also affects LSP cfg
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.opt.swapfile = false

-- Native LSP
require('lspconfig').pyright.setup({
    capabilities = capabilities, -- Read above
    on_attach = function()
        -- We are setting keymaps here because we want them only if the buffer is LSP capable
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0}) -- Show documentations, press twice to focus on pop up
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0}) -- Goto definition
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0}) -- Goto TYPE definition, good for Objects
        vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, {buffer=0})
        vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {buffer=0})
        vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics <cr>", {buffer=0}) -- CTRL-q to move them to quickfix list
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})
    end,
})


---- Tree-sitter configuration
require'nvim-treesitter.configs'.setup {
  ---- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}


-- Omnisharp
local nvim_lsp = require('lspconfig')
local pid = vim.fn.getpid()
local omnisharp_bin = "/home/leite/Downloads/linux/run"

require('lspconfig').omnisharp.setup({
    capabilities = capabilities,
    on_attach = function()
        -- We are setting keymaps here because we want them only if the buffer is LSP capable
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0}) -- Show documentations, press twice to focus on pop up
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0}) -- Goto definition
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0}) -- Goto TYPE definition, good for Objects
        vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, {buffer=0})
        vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {buffer=0})
        vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics <cr>", {buffer=0}) -- CTRL-q to move them to quickfix list
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})
    end,
    cmd = {omnisharp_bin, "--languageserver", "--hostPID", tostring(pid)},
    root_dir = nvim_lsp.util.root_pattern("*.csproj","*.sln"),
})


-- Autocomplete
local lspkind = require('lspkind') -- Pretty symbols
local cmp = require'cmp'

cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = function(fallback)
          if cmp.visible() then
              cmp.select_next_item()
          else
              fallback()
          end
      end,
      ["<S-Tab>"] = function(fallback)
          if cmp.visible() then
              cmp.select_prev_item()
          else
              fallback()
          end
      end
    }),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'luasnip' },
    },
    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                path = "[path]",
                luasnip = "[snip]",
            },
        },
    },
})


-- Gitsigns, I think it is an inside plugin, so I only have to require it, instead of PlugInstall

require('gitsigns').setup({
    signs = {
        add = {hl = 'GitSignsAdd', text = '█', numhl='GitSignsAddNr', linehl='GitSignsAddLn'},
        change = {hl = 'GitSignsChange', text = '█', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete = {hl = 'GitSignsDelete', text = '█', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    signcolumn = true,
    on_attach = function()
        local gs = package.loaded.gitsigns

        vim.keymap.set("n", "]c", function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, {expr=true})

        vim.keymap.set("n", "[c", function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, {expr=true})
    end,
})


-- Telescope
require('telescope').setup({
    defaults = {
        mapping = {
            -- Insert mode mappings
            i = {
                --["<c-a>"] = function() print("Hi") end
            }
        }
    }
})

require('telescope').load_extension('fzf')

local mapping = {}

mapping.find_in_buffer = function()
    local ops = require('telescope.themes').get_ivy()

    require('telescope.builtin').current_buffer_fuzzy_find(ops)
end

return mapping
