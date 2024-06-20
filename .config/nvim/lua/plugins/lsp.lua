-- return {
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		event = { "BufReadPost" },
-- 		cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
-- 		dependencies = {
-- 			-- Plugin and UI to automatically install LSPs to stdpath
-- 			"williamboman/mason.nvim",
-- 			"williamboman/mason-lspconfig.nvim",
--
-- 			"hrsh7th/cmp-nvim-lsp",
-- 			-- Install none-ls for diagnostics, code actions, and formatting
-- 			"nvimtools/none-ls.nvim",
--
-- 			-- Install neodev for better nvim configuration and plugin authoring via lsp configurations
-- 			"folke/neodev.nvim",
--
-- 			-- Progress/Status update for LSP
-- 			{ "j-hui/fidget.nvim", tag = "legacy" },
-- 		},
-- 		config = function()
-- 			local null_ls = require("null-ls")
-- 			local map_lsp_keybinds = require("user.keymaps").map_lsp_keybinds -- Has to load keymaps before pluginslsp
--
-- 			-- Use neodev to configure lua_ls in nvim directories - must load before lspconfig
-- 			require("neodev").setup()
--
-- 			-- Setup mason so it can manage 3rd party LSP servers
-- 			require("mason").setup({
-- 				ui = {
-- 					border = "rounded",
-- 				},
-- 			})
--
-- 			-- Configure mason to auto install servers
-- 			require("mason-lspconfig").setup({
-- 				automatic_installation = { exclude = { "ocamllsp", "gleam" } },
-- 				ensure_installed = {
-- 					"bashls",
-- 					"cssls",
-- 					"html",
-- 					"jsonls",
-- 					"lua_ls",
-- 					"clangd",
-- 					-- "clang-format",
-- 					"gopls",
-- 					"phpactor",
-- 					"taplo",
-- 					"dockerls",
-- 					"lemminx",
-- 					"rust_analyzer",
-- 					"jdtls", -- java
-- 				},
-- 			})
--
-- 			-- Override tsserver diagnostics to filter out specific messages
-- 			local messages_to_filter = {
-- 				"This may be converted to an async function.",
-- 				"'_Assertion' is declared but never used.",
-- 				"'__Assertion' is declared but never used.",
-- 				"The signature '(data: string): string' of 'atob' is deprecated.",
-- 				"The signature '(data: string): string' of 'btoa' is deprecated.",
-- 			}
--
-- 			local function tsserver_on_publish_diagnostics_override(_, result, ctx, config)
-- 				local filtered_diagnostics = {}
--
-- 				for _, diagnostic in ipairs(result.diagnostics) do
-- 					local found = false
-- 					for _, message in ipairs(messages_to_filter) do
-- 						if diagnostic.message == message then
-- 							found = true
-- 							break
-- 						end
-- 					end
-- 					if not found then
-- 						table.insert(filtered_diagnostics, diagnostic)
-- 					end
-- 				end
--
-- 				result.diagnostics = filtered_diagnostics
--
-- 				vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
-- 			end
--
-- 			-- LSP servers to install (see list here: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers )
-- 			local servers = {
--
-- 				csharp_ls = {},
-- 				jdtls = {
-- 					cmd = { "/home/copernicus/.local/share/nvim/mason/bin/jdtls" },
-- 				},
-- 				bashls = {},
-- 				clangd = {
-- 					cmd = {
-- 						"clangd",
-- 						"--offset-encoding=utf-16",
-- 					},
-- 				},
-- 				cssls = {},
-- 				gleam = {},
-- 				-- graphql = {},
-- 				html = {},
-- 				jsonls = {},
-- 				lua_ls = {
-- 					settings = {
-- 						Lua = {
-- 							workspace = { checkThirdParty = false },
-- 							telemetry = { enabled = false },
-- 						},
-- 					},
-- 				},
-- 				gopls = {
-- 					-- capabilities = default_capabilities,
-- 					-- filetypes = config.filetypes,
-- 					-- handlers = vim.tbl_deep_extend("force", {}, default_handlers, config.handlers or {}),
-- 					-- on_attach = on_attach,
-- 					-- settings = config.settings,
-- 					filetypes = {
-- 						"go",
-- 						"gomod",
-- 						"gowork",
-- 						"gotmpl",
-- 					},
-- 					root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
-- 					settings = {
-- 						gopls = {
-- 							completeUnimported = true,
-- 							usePlaceholders = true,
-- 							analyses = {
-- 								unusedparams = true,
-- 							},
-- 						},
-- 					},
-- 				},
-- 				-- marksman = {},
-- 				-- nil_ls = {},
-- 				-- eslint_d = {},
-- 				eslint = {},
-- 				-- ocamllsp = {},
-- 				prismals = {},
-- 				pyright = {},
-- 				-- solidity = {},
-- 				sqlls = {},
-- 				tailwindcss = {
-- 					-- filetypes = { "reason" },
-- 				},
-- 				tsserver = {
-- 					settings = {
-- 						experimental = {
-- 							enableProjectDiagnostics = true,
-- 						},
-- 					},
-- 					handlers = {
-- 						["textDocument/publishDiagnostics"] = vim.lsp.with(
-- 							tsserver_on_publish_diagnostics_override,
-- 							{}
-- 						),
-- 					},
-- 				},
-- 				yamlls = {},
-- 				phpactor = {},
-- 				taplo = {},
-- 				dockerls = {},
-- 				lemminx = {},
-- 				rust_analyzer = {
-- 					settings = {
-- 						["rust-analyzer"] = {
-- 							cargo = { allFeatures = true },
-- 						},
-- 					},
-- 				},
-- 				twiggy_language_server = {},
-- 				-- java_language_server = {},
-- 			}
--
-- 			-- Default handlers for LSP
-- 			local default_handlers = {
-- 				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
-- 				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
-- 			}
--
-- 			-- nvim-cmp supports additional completion capabilities
-- 			local capabilities = vim.lsp.protocol.make_client_capabilities()
-- 			local default_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
--
-- 			---@diagnostic disable-next-line: unused-local
-- 			local on_attach = function(_client, buffer_number)
-- 				-- Pass the current buffer to map lsp keybinds
-- 				map_lsp_keybinds(buffer_number)
--
-- 				-- Create a command `:Format` local to the LSP buffer
-- 				vim.api.nvim_buf_create_user_command(buffer_number, "Format", function(_)
-- 					vim.lsp.buf.format({
-- 						filter = function(format_client)
-- 							-- Use Prettier to format TS/JS if it's available
-- 							return format_client.name ~= "tsserver" or not null_ls.is_registered("prettier")
-- 						end,
-- 					})
-- 				end, { desc = "LSP: Format current buffer with LSP" })
--
-- 				vim.lsp.inlay_hint.enable(true, { bufnr = buffer_number })
--
-- 				-- if client.server_capabilities.codeLensProvider then
-- 					vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
-- 						buffer = buffer_number,
-- 						callback = vim.lsp.codelens.refresh,
-- 						desc = "LSP: Refresh code lens",
-- 						group = vim.api.nvim_create_augroup("codelens", { clear = true }),
-- 					})
-- 				-- end
-- 			end
--
-- 			-- Iterate over our servers and set them up
-- 			for name, config in pairs(servers) do
-- 				require("lspconfig")[name].setup({
-- 					capabilities = default_capabilities,
-- 					filetypes = config.filetypes,
-- 					handlers = vim.tbl_deep_extend("force", {}, default_handlers, config.handlers or {}),
-- 					on_attach = on_attach,
-- 					settings = config.settings,
-- 					root_dir = config.root_dir,
-- 					cmd = config.cmd,
-- 				})
-- 			end
--
-- 			-- Congifure LSP linting, formatting, diagnostics, and code actions
-- 			local formatting = null_ls.builtins.formatting
-- 			local diagnostics = null_ls.builtins.diagnostics
-- 			local code_actions = null_ls.builtins.code_actions
--
-- 			null_ls.setup({
-- 				border = "rounded",
-- 				sources = {
-- 					-- formatting
-- 					formatting.prettierd,
-- 					formatting.stylua,
-- 					formatting.ocamlformat,
-- 					formatting.gofumpt,
-- 					formatting.goimports_reviser,
-- 					formatting.golines,
-- 					formatting.phpcsfixer,
-- 					formatting.black,
-- 					formatting.goimports,
-- 					--formatting.twigcsfixer,
-- 					-- formatting.clang_format,
--
-- 					-- diagnostics for js/ts
-- 					-- diagnostics.eslint.with({
-- 					-- 	condition = function(utils)
-- 					-- 		return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" })
-- 					-- 	end,
-- 					-- }),
-- 					--
-- 					-- -- code actions for js/ts
-- 					-- code_actions.eslint.with({
-- 					-- 	condition = function(utils)
-- 					-- 		return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" })
-- 					-- 	end,
-- 					-- }),
-- 				},
-- 			})
--
-- 			-- Configure borderd for LspInfo ui
-- 			require("lspconfig.ui.windows").default_options.border = "rounded"
--
-- 			-- Configure diagostics border
-- 			vim.diagnostic.config({
-- 				float = {
-- 					border = "rounded",
-- 				},
-- 			})
-- 		end,
-- 	},
-- }
return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
		dependencies = {
			-- Plugin(s) and UI to automatically install LSPs to stdpath
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Install lsp autocompletions
			"hrsh7th/cmp-nvim-lsp",

			-- Progress/Status update for LSP
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			local map_lsp_keybinds = require("user.keymaps").map_lsp_keybinds -- Has to load keymaps before pluginslsp

			-- Override tsserver diagnostics to filter out specific messages
			local messages_to_filter = {
				"This may be converted to an async function.",
			}

			local function tsserver_on_publish_diagnostics_override(_, result, ctx, config)
				local filtered_diagnostics = {}

				for _, diagnostic in ipairs(result.diagnostics) do
					local found = false
					for _, message in ipairs(messages_to_filter) do
						if diagnostic.message == message then
							found = true
							break
						end
					end
					if not found then
						table.insert(filtered_diagnostics, diagnostic)
					end
				end

				result.diagnostics = filtered_diagnostics

				vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
			end

			-- Default handlers for LSP
			local default_handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
			}

			-- Function to run when neovim connects to a Lsp client
			---@diagnostic disable-next-line: unused-local
			local on_attach = function(client, buffer_number)
				-- Pass the current buffer to map lsp keybinds
				map_lsp_keybinds(buffer_number)
				if client.name == "rust_analyzer" then
					vim.lsp.inlay_hint.enable(true, { bufnr = buffer_number })
				end
			end

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP Specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- LSP servers to install (see list here: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers )
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				-- LSP Servers
				bashls = {},
				biome = {},
				cssls = {},
				gleam = {},
				eslint = {
					autostart = false,
					cmd = { "vscode-eslint-language-server", "--stdio", "--max-old-space-size=12288" },
					settings = {
						format = false,
					},
				},
				html = {},
				jsonls = {},
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								-- Tells lua_ls where to find all the Lua files that you have loaded
								-- for your neovim configuration.
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
							},
							telemetry = { enabled = false },
						},
					},
				},
				marksman = {},
				ocamllsp = {
					settings = {
						inlayHints = true,
					},
				},
				nil_ls = {},
				pyright = {},
				sqlls = {},
				tailwindcss = {},
				tsserver = {
					settings = {
						maxTsServerMemory = 12288,
						typescript = {
							inlayHints = {
								includeInlayEnumMemberValueHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayEnumMemberValueHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							},
						},
					},
					handlers = {
						["textDocument/publishDiagnostics"] = vim.lsp.with(
							tsserver_on_publish_diagnostics_override,
							{}
						),
					},
				},
				yamlls = {},
				svelte = {},
        gopls = {
					settings = {
						gopls = {
							completeUnimported = true,
							usePlaceholders = true,
							analyses = {
								unusedparams = true,
							},
						},
					},
        },
				rust_analyzer = {
					settings = {
						inlayHints = true,
					},
					check = {
						command = "clippy",
					},
				},
			}

			local formatters = {
				prettierd = {},
				stylua = {},
			}

			local manually_installed_servers = { "ocamllsp", "gleam", "rust_analyzer" }

			local mason_tools_to_install = vim.tbl_keys(vim.tbl_deep_extend("force", {}, servers, formatters))

			local ensure_installed = vim.tbl_filter(function(name)
				return not vim.tbl_contains(manually_installed_servers, name)
			end, mason_tools_to_install)

			require("mason-tool-installer").setup({
				auto_update = true,
				run_on_start = true,
				start_delay = 3000,
				debounce_hours = 12,
				ensure_installed = ensure_installed,
			})

			-- Iterate over our servers and set them up
			for name, config in pairs(servers) do
				require("lspconfig")[name].setup({
					autostart = config.autostart,
					cmd = config.cmd,
					capabilities = capabilities,
					filetypes = config.filetypes,
					handlers = vim.tbl_deep_extend("force", {}, default_handlers, config.handlers or {}),
					on_attach = on_attach,
					settings = config.settings,
					root_dir = config.root_dir,
				})
			end

			-- Setup mason so it can manage 3rd party LSP servers
			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})

			require("mason-lspconfig").setup()

			-- Configure borderd for LspInfo ui
			require("lspconfig.ui.windows").default_options.border = "rounded"

			-- Configure diagnostics border
			vim.diagnostic.config({
				float = {
					border = "rounded",
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			notify_on_error = false,
			format_after_save = {
				async = true,
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				javascript = { { "prettierd", "prettier", "biome" } },
				typescript = { { "prettierd", "prettier", "biome" } },
				typescriptreact = { { "prettierd", "prettier", "biome" } },
				svelte = { { "prettierd", "prettier " } },
				lua = { "stylua" },
			},
		},
	},
}
