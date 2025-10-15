local codecompanion = require("codecompanion")

codecompanion.setup({
  strategies = {
    chat   = { adapter = "ollama" },
    inline = { adapter = "ollama" },
    agent  = { adapter = "ollama" },
  },
  adapters = {
    ollama = function()
      return require("codecompanion.adapters").extend("ollama", {
        env = {
          url     = "http://localhost:11434",
          --api_key = "ollama",
        },
        schema = {
          model = { default = "gpt-oss:20b" },  -- adjust to your model
        },
      })
    end,
  },
  opts = {
    log_level = 'DEBUG'
  },
  display = {
    close_chat_at = 240, -- Close chat when window gets too narrow
  },

  -- ────────────────────────────────────────
  -- Keymaps (overrides the defaults)
  -- ────────────────────────────────────────
  -- keymaps = {
  --   trigger   = "<C-Space>",   -- open the suggestion menu
  --   accept   = "<CR>",         -- accept the current completion
  --   run      = "<leader>rc",   -- run the snippet in terminal
  --   history  = "<leader>ch",   -- show previous suggestions
  -- },

})
