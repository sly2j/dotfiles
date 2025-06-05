local lazypath = vim.fn.stdpath("config") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Theme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  { "nvim-lua/plenary.nvim" }, -- Utility library used by many plugins (required for cmake-tools, Avante, telescope, etc.)
  { "dstein64/vim-startuptime", cmd = "StartupTime" }, -- startup time profiling

  -- Telescope for finding files
  -- Note: Telescope requires ripgrep to be installed, e.g. `brew install ripgrep` on MacOS
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
      }
    }
  },
  -- File file tree
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {}
    end,
  },
  -- Visualize buffers as tabs
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies='nvim-tree/nvim-web-devicons',
  },
  -- Easily toggle lines as comments
  {
    'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup({ create_mappigns = false })
    end
  },
  -- Highlight words under the cursor
  {
    "RRethy/vim-illuminate",
    config = function()
      -- Automatically highlights other occurrences of the word under the cursor.
      -- Useful for code comprehension (e.g., see all uses of a variable).
      require("illuminate").configure({
        delay = 100,
        filetypes_denylist = { "NvimTree", "TelescopePrompt", "dashboard" },
      })
    end
  },

  -- Statusline
  --{ "vim-airline/vim-airline" },

  -- Syntax highlighting and parsing via Tree-sitter
  -- Tree-sitter: Modern, fast, and extensible syntax parser and highlighter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",  -- Always keep parsers up to date
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c", "cpp", "python", "lua", "bash", "json", "yaml", "cmake", "markdown",
          "fortran", "toml", "java" -- Additional languages you requested
        },

        -- Enable Tree-sitter-based syntax highlighting
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false, -- Avoid duplicate highlights
        },

        -- Enable Tree-sitter-based indentation where supported
        indent = {
          enable = true,
        },

        -- Enable incremental selection:
        -- lets you expand/shrink the current selection by syntax node
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",           -- Start selection (e.g., inside a function)
            node_incremental = "<CR>",         -- Expand to next larger syntax node
            node_decremental = "<BS>",         -- Shrink to smaller syntax node
            scope_incremental = "<TAB>",       -- Expand to enclosing scope (e.g., if → function → class)
          },
        },

        -- Enable rainbow parentheses: matching delimiters get colorized in nested groups
        rainbow = {
          enable = true,
          extended_mode = true,                -- Highlight more than just (), e.g., [], {}
          max_file_lines = nil,                -- No file line limit (can set to avoid perf issues)
        },
      })
    end,
  },

  -- Rainbow delimiter colors using Tree-sitter
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },
  -- LSP Core Components
  { "williamboman/mason.nvim", version = "v1.10.0", build = ":MasonUpdate" },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "v1.29.0",
    dependencies = { "williamboman/mason.nvim" }
  },
  { "neovim/nvim-lspconfig" },
  { "WhoIsSethDaniel/mason-tool-installer.nvim" }, -- auto-installer for required tools

  -- Autocompletion stack
  { "hrsh7th/nvim-cmp" },         -- Completion engine
  { "hrsh7th/cmp-nvim-lsp" },     -- Required for LSP + nvim-cmp
  { "hrsh7th/cmp-buffer" },       -- Optional buffer-based word completion
  { "hrsh7th/cmp-path" },         -- Optional path completion
  { "L3MON4D3/LuaSnip" },         -- Snippet engine, alternative option is vsnip
  { "saadparwaiz1/cmp_luasnip" }, -- Connects LuaSnip with nvim-cmp
  { "onsails/lspkind.nvim" },     -- Adds icons to LSP completion items
  { "hrsh7th/cmp-nvim-lua" },     -- Lua API completion (e.g., for editing Neovim config)
  { "hrsh7th/cmp-cmdline" },      -- Completion in :cmdline and search (/, ?)

  -- IDE-like CMake Integration
  {
    "Civitasv/cmake-tools.nvim",
    config = function()
      require("cmake-tools").setup {
        cmake_command = "cmake",
        cmake_build_directory = "build/${variant:buildType}",
        cmake_generate_options = {
          "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
        },
        cmake_soft_link_compile_commands = true,
        cmake_kits_path = nil,
        cmake_variants_message = {
          short = { show = true },
          long = { show = false },
        },
        cmake_dap_configuration = {
          name = "cpp",
          type = "lldb",
          request = "launch",
          stopOnEntry = false,
          runInTerminal = true,
        },
      }
    end,
  },

  -- Git
  { "tpope/vim-fugitive" },

  -- Avante code agent
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this to "*"
    opts = {
      provider = "openai",
      providers = {
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4.1-mini",
          extra_request_body = {
            temperature = 0.75,
            max_completion_tokens = 8192,
          },
        },
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.pick",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "ibhagwan/fzf-lua",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  -- Obsidian.nvim: Integrates Neovim with your Obsidian vault for Markdown note-taking.
  -- Supports link following, backlinks, completion, and more.

  {
    "epwalsh/obsidian.nvim",
    version = "*",         -- Always use the latest release
    lazy = true,           -- Only load for relevant filetypes
    ft = "markdown",       -- Activate only for Markdown files
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for filesystem and async utilities
    }
  }
})


