vim.opt.termguicolors = true

vim.opt.foldcolumn = "0"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.cmd([[ 
set foldtext=FoldT()

function FoldT()
	let fs = v:foldstart
	while getline(fs) =~ '\^s*$' | let fs = nextnonblank(fs + 1)
	endwhile
	if fs > v:foldend
		let line = getline(v:foldstart)
	else
		let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
	endif
	" let nline = getline(nextnonblank(fs + 1)) . " " 
	let w = winwidth(0) - (&number ? 8 : 0)
	let foldSize = 1 + v:foldend - v:foldstart
	let foldSizeStr = " " . foldSize . " lines "
	if v:foldlevel == 1
		let foldLvlStr = "⧽⧿"
	else 
		let foldLvlStr = "⧽⧿" . repeat("⧾⧿", v:foldlevel - 1)
	endif
	let expStr = repeat(" ", (w - strwidth(foldSizeStr.line.foldLvlStr)) + 2)
	return line . expStr . foldSizeStr . foldLvlStr
endfunction
]])

vim.opt.foldlevel = 99
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 4
vim.opt.fillchars = ''

vim.keymap.set({'n', 'v'}, 'j', 'h')
vim.keymap.set({'n', 'v'}, 'k', 'gj')
vim.keymap.set({'n', 'v'}, 'l', 'gk')
vim.keymap.set({'n', 'v'}, ';', 'l')

local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug 'nvim-mini/mini.nvim'

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

require('mini.comment').setup()
MiniComment.config = {
	options = {
		custom_commentstring = nil,
		ignore_blank_line = true,
		start_of_line = false,
		pad_comment_parts = true,
	},
	mappings = {
		comment = '',
		comment_line = 'gc',
		comment_visual = 'gc'
	},
	hooks = {
		pre = function() end,
		post = function() end,
	},
}

require('mini.indentscope').setup()
MiniIndentscope.config = {
	draw = {
		delay = 75,
		animation = MiniIndentscope.gen_animation.cubic({
			easing = 'out',
			duration = 12,
			unit = "step",
		}),
		-- animation =  MiniIndentscope.gen_animation.none(),
		predicate = function(scope) return not scope.body.is_incomplete end,

	},
	options = {
		border = 'both',
		indent_at_cursor = true,
		n_lines = 5000,
		try_as_border = false,
	},
	symbol = '┆',
	-- symbol = '⁑',
}

local cmp = require('cmp')
local luasnip = require('luasnip')
local nvim_cursorline = require('nvim-cursorline')

vim.api.nvim_create_autocmd('Filetype', {
	pattern = {'c', 'cpp', 'h', 'hpp', 'asm', 'sh', 'md', 'mkdn', 'nasm', 'fasm', 'json', 'lua', 'conf'},
	callback = function()
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
	window = {
		completion = cmp.config.window.bordered()
	},
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

local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('clangd', {
	settings = {
		['clangd'] = { capabilities = capabilities },
	},
})
vim.lsp.enable('clangd')

require('nnn').setup()

nvim_cursorline.setup {
	cursorline = {
		enable = true,
		timeout = 300,
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
