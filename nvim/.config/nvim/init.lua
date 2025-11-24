-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.cmd([[
  cnoreabbrev q echo "':q' is disabled"
]])
-- Load the lspconfig module
local lspconfig = require("lspconfig")

-- Function to handle buffer setup (like setting keymaps, etc.)
local on_attach = function(client, bufnr)
  -- EXAMPLE: Set up formatting command to use the attached LSP
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = true })
      end,
    })
  end

  -- Crucial for the Ruff LSP configuration below
  if client.name == "ruff_lsp" then
    -- Tell the client not to provide hover/documentation, as Pyright is better at it
    client.server_capabilities.hoverProvider = false
  end
end

----------------------------------------------------------------------
-- 1. 🐍 Configure Pyright (Type Checking and Code Intelligence)
----------------------------------------------------------------------
lspconfig.pyright.setup({
  on_attach = on_attach, -- Use the common attachment function
  settings = {
    python = {
      analysis = {
        -- Set type checking mode to strict for robust type checking
        typeCheckingMode = "basic",
        -- Disable Pyright's general linting diagnostics
        -- so only Ruff provides them (set to "workspace")
        diagnosticMode = "workspace",
      },
    },
    pyright = {
      -- Prevent Pyright from running its own organize imports (Ruff does this)
      disableOrganizeImports = true,
    },
  },
})

----------------------------------------------------------------------
-- 2. ⚡ Configure Ruff LSP (Linting and Formatting)
----------------------------------------------------------------------
lspconfig.ruff_lsp.setup({
  on_attach = on_attach, -- Use the common attachment function
  -- You can add extra settings here if you need to pass specific arguments to Ruff LSP
})

-- The old vim.lsp.enable is no longer needed here.
-- lspconfig handles starting the server when you open a Python file.
-- vim.lsp.enable({})
