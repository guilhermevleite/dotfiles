-- Client telling the server: here's what I can do!
-- This is part of autocomplete, but also affects LSP cfg
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Native LSP
require('lspconfig').pyright.setup{
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
    end
}


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
      { name = 'buffer', keyword_length = 5 },
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


-- Telescope
require('telescope').setup{
    defaults = {
        mapping = {
            -- Insert mode mappings
            i = {
                ["<c-a>"] = function() print("Hi") end
            }
        }
    }
}

require('telescope').load_extension('fzf')

local mapping = {}


mapping.find_in_buffer = function()
    local ops = require('telescope.themes').get_ivy()

    require('telescope.builtin').current_buffer_fuzzy_find(ops)
end

return mapping
