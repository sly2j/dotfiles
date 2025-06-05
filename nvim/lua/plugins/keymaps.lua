-- Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fp", ":Telescope git_files<cr>")
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fo", ":Telescope oldfiles<cr>")

-- File NerdTree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")

-- nvim-comment
vim.keymap.set({'n', 'v'}, '<leader>/', ':CommentToggle<cr>')

-- yank to clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', [["+y]])

-- CMake Tools Keymaps
vim.keymap.set("n", "<leader>cg", ":CMakeGenerate<CR>", { desc = "CMake: Generate", silent = true })
vim.keymap.set("n", "<leader>cb", ":CMakeBuild<CR>", { desc = "CMake: Build", silent = true })
vim.keymap.set("n", "<leader>cc", ":CMakeClean<CR>", { desc = "CMake: Clean", silent = true })
vim.keymap.set("n", "<leader>ct", ":CMakeRun<CR>", { desc = "CMake: Run Target", silent = true })
vim.keymap.set("n", "<leader>cs", ":CMakeSelectBuildType<CR>", { desc = "CMake: Select Build Type", silent = true })
vim.keymap.set("n", "<leader>cp", ":CMakeSelectConfigurePreset<CR>", { desc = "CMake: Select Preset", silent = true })

-- Show hover information (docstrings, type info, etc.) from LSP
-- Useful for inspecting functions, variables, etc. with `K` in normal mode
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })

-- Toggle inlay hints (e.g., parameter names, types) on/off
-- Helpful to reduce visual clutter when desired, especially in C++
-- Only works in Neovim 0.10+ (or patched 0.9) with a compatible LSP
vim.keymap.set("n", "<leader>ih", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local enabled = vim.lsp.inlay_hint.is_enabled(bufnr)
  vim.lsp.inlay_hint.enable(bufnr, not enabled)
end, { desc = "Toggle Inlay Hints" })

-- LSP Navigation
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP: Find references" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename symbol" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code action" })

-- Diagnostic Navigation
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

-- LSP-based formatting using <C-k>
-- This keymap supports both:
--   - Normal mode: format the entire file
--   - Visual mode: format only the selected lines
vim.keymap.set({ "n", "v" }, "<C-k>", function()
  -- Check if the user is in visual mode
  if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
    -- Get start and end line numbers of the visual selection
    local start_pos = vim.fn.getpos("'<") -- [bufnum, lnum, col, off]
    local end_pos = vim.fn.getpos("'>")

    -- Call LSP's format function with a specified range
    vim.lsp.buf.format({
      range = {
        -- LSP uses 0-based line numbers, so subtract 1
        ["start"] = { line = start_pos[2] - 1, character = 0 },
        ["end"]   = { line = end_pos[2], character = 0 },
      },
      async = true,
    })
  else
    -- If not in visual mode, format the entire file
    vim.lsp.buf.format({ async = true })
  end
end, { desc = "LSP Format (buffer or selection)" })
