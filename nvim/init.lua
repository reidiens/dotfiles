vim.opt.termguicolors = true

local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug 'jiangmiao/auto-pairs'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug('L3MON4D3/LuaSnip', {['tag'] = 'v2.*', ['do'] = 'make install_jsregexp'})
Plug 'saadparwaiz1/cmp_luasnip'

Plug('bluz71/vim-moonfly-colors', {['as'] = 'moonfly'})

Plug 'itchyny/lightline.vim'

Plug 'luukvbaal/nnn.nvim'

Plug 'ya2s/nvim-cursorline'

Plug 'nvim-lua/plenary.nvim'

vim.call('plug#end')

vim.g.lightline = {['colorscheme'] = 'moonfly'}

vim.cmd [[colorscheme moonfly]]
vim.cmd [[set noshowmode]]
vim.cmd [[set laststatus=2]]

local cmp = require('cmp')
local luasnip = require('luasnip')
local nvim_cursorline = require('nvim-cursorline')

vim.api.nvim_create_autocmd('Filetype', {
	pattern = {'c', 'cpp', 'h', 'hpp', 'asm', 'sh', 'md', 'mkdn', 'nasm', 'fasm', 'json', 'lua', 'conf'},
	callback = function()
		vim.keymap.set({'n', 'v'}, 'j', 'gj')
		vim.keymap.set({'n', 'v'}, 'k', 'gk')
		vim.cmd [[set number]]
		vim.cmd [[set tabstop=4]]
		vim.cmd [[set shiftwidth=4]]
	end
})

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	window = { completion = cmp.config.window.bordered() },
	mapping = cmp.mapping.preset.insert({
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if luasnip.expandable() then
					luasnip.expand()
				else
					cmp.confirm({ select = true })
				end
			else fallback() end
		end, {"i", "s"}) ,

		['<C-k>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.locally_jumpable(1) then
				luasnip.jump(1)
			else fallback() end
		end),

		["<C-j>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else fallback() end
		end)
	}),
	sources = cmp.config.sources({
		{name = 'nvim_lsp'},
		{name = 'luasnip'},
		{name = 'buffer'},
	})

})

require('lspconfig')['clangd'].setup {
	capabilities = require('cmp_nvim_lsp').default_capabilities()
}

require('nnn').setup({ buflisted = true })

nvim_cursorline.setup {
	cursorline = {
		enable = true,
		timeout = 325,
		number = true
	},
	cursorword = {
		enable = true,
		min_length = 3,
		h1 = { underline = true },
	}
}

vim.g.moonflyCursorColor = true
vim.g.moonflyTerminalColors = false
