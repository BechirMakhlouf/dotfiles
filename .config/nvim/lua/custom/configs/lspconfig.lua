local baseConfig = require("plugins.configs.lspconfig");

local on_attach = baseConfig.on_attach
local capabilities = baseConfig.capabilities

local lspconfig = require("lspconfig")

local lsp_servers = {
  "tsserver",
  "tailwindcss",
  "eslint",
  "cssls",
}

for _, lsp in ipairs(lsp_servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end
