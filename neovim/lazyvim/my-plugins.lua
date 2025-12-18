return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = false,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
      "meanderingprogrammer/render-markdown.nvim",

      -- see above for full list of optional dependencies ☝️
    },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      ui = { enabled = false },

      workspaces = {
        {
          name = "notes",
          path = "/mnt/nv/Notes/general",
        },
        {
          name = "pd",
          path = "/mnt/nv/Notes/postdoc",
        },
        {
          name = "phd",
          path = "/mnt/nv/Notes/phd",
        },
        {
          name = "farmgame",
          path = "/mnt/nv/Notes/farm_game",
        },
        {
          name = "diy",
          path = "/mnt/nv/Notes/DIY",
        },
      },

      checkbox = {
        enabled = true,
        create_new = true,
        order = { " ", "x", "~", "!", ">" },
      },

      notes_subdir = "memos/",

      daily_notes = {
        folder = "dailies",
        default_tags = { "daily-notes" },
      },

      preferred_link_style = "markdown",
    },
  },

  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      heading = {
        enabled = true,
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        signs = { "󰫎 " },
      },
      checkbox = {
        enabled = true,
        render_modes = false,
        bullet = false,
        left_pad = 0,
        right_pad = 1,
        unchecked = {
          icon = "󰄱 ",
          highlight = "RenderMarkdownUnchecked",
          scope_highlight = nil,
        },
        checked = {
          icon = "󰱒 ",
          highlight = "RenderMarkdownChecked",
          scope_highlight = "@markup.strikethrough",
        },
        custom = {
          todo = {
            raw = "[~]",
            rendered = "󰥔 ",
            highlight = "RenderMarkdownTodo",
            scope_highlight = nil,
          },
          important = {
            raw = "[!]",
            rendered = "󰓎 ",
            highlight = "DiagnosticWarn",
          },
        },
        scope_priority = nil,
      },
      pipe_table = {
        style = "normal",
        alignment_indicator = "┅",
      },
    },
  },
}
