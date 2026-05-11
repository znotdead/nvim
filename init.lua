-- plugins
local gh = function(x) return 'https://github.com/' .. x end

-- to list all plugins run command:
-- :lua vim.pack.update(nil, { offline = true })

vim.pack.add({
    -- file tree
    gh('scrooloose/nerdtree'), -- or consider nvim-tree later
    -- tab display of buffers
    gh('vim-airline/vim-airline'),
    -- syntax checking (FIXME: deprecated switch to dense-analysis/ale than prettier won't needed)
    -- Plug 'prettier/vim-prettier', {
    --   \ 'do': 'npm install',
    --   \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }
    gh('scrooloose/syntastic'),
    -- " Fuzzy
    gh('ibhagwan/fzf-lua'),
    -- show definitions
    -- gh('majutsushi/tagbar'),

    -- AI and completion
    gh('neovim/nvim-lspconfig'),
    gh('hrsh7th/nvim-cmp'),
    gh('hrsh7th/cmp-nvim-lsp'),
    gh('hrsh7th/cmp-buffer'),
    gh('hrsh7th/cmp-path'),
    gh('L3MON4D3/LuaSnip'),
    gh('saadparwaiz1/cmp_luasnip'),
    gh('milanglacier/minuet-ai.nvim'),

    -- " Snippets (from ultisnips to luasnip)
    gh('znotdead/vim-snippets'),
    -- gh('mhartington/vim-angular2-snippets'),

    -- " Diff languages helpers
    -- " RUST
    -- gh('rust-lang/rust.vim'),
    -- " toml
    -- gh('cespare/vim-toml'),
    -- " Typescript
    -- gh('leafgarland/typescript-vim'),
    -- " Python
    -- gh('jmcantrell/vim-virtualenv')
    -- gh('fs111/pydoc.vim'),
    -- gh('fisadev/vim-isort'),
    gh('hdima/python-syntax'),
    -- " HTML
    -- gh('rstacruz/sparkup')
    -- " Git
    -- gh('tpope/vim-fugitive')
})
--Clean UP: remove inactive after plugin add
vim.pack.del(vim.iter(vim.pack.get())
 :filter(function(x) return not x.active end)
 :map(function(x) return x.spec.name end)
 :totable()
)


-- " ------------------------------------------------------------------------------
-- " NERDTree Settings
-- " ------------------------------------------------------------------------------
-- " Hide python cache files (.pyc) in NERDTree
vim.NERDTreeIgnore= {'\\.pyc'}
-- " open NERDTree with start directory
vim.keymap.set('n', '<F9>', ':NERDTreeToggle ~/projects/<CR>')
vim.NERDTreeShowBookmarks=1
-- " automatically open NERDtree
vim.api.nvim_create_autocmd("VimEnter", { command = "NERDTree" })

-- " ------------------------------------------------------------------------------
-- " Airline settings
-- " ------------------------------------------------------------------------------
-- let g:airline_powerline_fonts = 1
vim.g.airline_detect_modified = 1
-- let g:airline_detect_paste = 1
-- let g:airline_theme = 'dark'
vim.g['airline#extensions#tabline#fnamemod'] = ':t'
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#buffer_idx_mode'] = 1
vim.g['airline#extensions#tabline#left_sep'] = '|'
vim.g['airline#extensions#tabline#left_alt_sep'] = '|'
vim.g['airline#extensions#tabline#right_sep'] = '|'
vim.g['airline#extensions#tabline#right_alt_sep'] = '|'
-- "nmap <M-1> <Plug>AirlineSelectTab1
-- "nmap <M-2> <Plug>AirlineSelectTab2
-- "nmap <M-3> <Plug>AirlineSelectTab3
-- "nmap <M-4> <Plug>AirlineSelectTab4
-- "nmap <M-5> <Plug>AirlineSelectTab5
-- "nmap <M-6> <Plug>AirlineSelectTab6
-- "nmap <M-7> <Plug>AirlineSelectTab7
-- "nmap <M-8> <Plug>AirlineSelectTab8
-- "nmap <M-9> <Plug>AirlineSelectTab9
vim.keymap.set('n', '<M-,>', '<Plug>AirlineSelectPrevTab')
vim.keymap.set('n', '<M-.>', '<Plug>AirlineSelectNextTab')
vim.g.airline_extensions = {'syntastic', 'tabline'}

-- status line settings
vim.opt.statusline:append('%#warningmsg#')
-- FIXME vim.opt.statusline:append('%{SyntasticStatuslineFlag()')
vim.opt.statusline:append('%*')

-- " ------------------------------------------------------------------------------
-- " Syntastic  settings
-- " ------------------------------------------------------------------------------
-- syntax checking
vim.g['syntastic_always_populate_loc_list'] = 1
vim.g['syntastic_auto_loc_list'] = 1
vim.g['syntastic_check_on_open'] = 1
vim.g['syntastic_check_on_wq'] = 0
vim.g['syntastic_python_checkers']={'flake8'}
vim.g['syntastic_python_flake8_args']='--max-line-length=100'
-- "-------------------------------------------------------------------------------
-- " Fuzzy Finder fzf-lua
-- "-------------------------------------------------------------------------------
local fzf = require('fzf-lua')

fzf.setup({
  winopts = {
    height = 0.85,
    width = 0.80,
    preview = {
      horizontal = "right:50%",
      vertical = "down:60%",
    },
  },
  files = {
    previewer = "builtin",
  },
})

-- ====================== Keymappings ======================
-- <M-o> for files (your original)
vim.keymap.set('n', '<M-o>', function() fzf.files() end, { desc = "fzf Files" })
vim.keymap.set('v', '<M-o>', function() fzf.files() end, { desc = "fzf Files" })

-- Common useful mappings
vim.keymap.set('n', '<leader>ff', function() fzf.files() end, { desc = "Find Files" })
vim.keymap.set('n', '<leader>fg', function() fzf.live_grep() end, { desc = "Live Grep" })
vim.keymap.set('n', '<leader>fb', function() fzf.buffers() end, { desc = "Buffers" })
vim.keymap.set('n', '<leader>fh', function() fzf.help_tags() end, { desc = "Help Tags" })

-- ====================== Rg and Rga Commands ======================
-- Rg  → First match per file (like your old Rg)
vim.api.nvim_create_user_command('Rg', function(opts)
  fzf.grep({
    search = opts.args,
    rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-count=1",
  })
end, { nargs = "*", complete = "file" })

-- Rga → All matches (like your old Rga)
vim.api.nvim_create_user_command('Rga', function(opts)
  fzf.grep({
    search = opts.args,
    rg_opts = "--column --line-number --no-heading --color=always --smart-case",
  })
end, { nargs = "*", complete = "file" })

-- Live grep with preview
vim.api.nvim_create_user_command('RgLive', function()
  fzf.live_grep()
end, {})


-- " ------------------------------------------------------------------------------
-- " Virtualenv
-- " ------------------------------------------------------------------------------
-- " :VirtualEnvActivate
-- " :VirtualEnvDeactivate
-- 
-- " ------------------------------------------------------------------------------
-- " Pydoc
-- " ------------------------------------------------------------------------------
-- " ,pw - show docs for word
-- " ,pk - search by keyword
-- " :Pydoc <module>
-- " ------------------------------------------------------------------------------
-- " GIT Fugitive settings
-- " ------------------------------------------------------------------------------
-- set statusline+=%{FugitiveStatusline()}
-- " ------------------------------------------------------------------------------
-- " Sparkup
-- " ------------------------------------------------------------------------------
-- " Ctrl+E, Ctrl+n
-- 
-- "-------------------------------------------------------------------------------
-- " Tagbar
-- "-------------------------------------------------------------------------------
-- vim.keymap.set("n", "<F8>", ":TagbarToggle<CR>")
-- 
-- "-------------------------------------------------------------------------------
-- " Taglist
-- "-------------------------------------------------------------------------------
-- " Taglist variables
-- " Display function name in status bar:
-- "let g:ctags_statusline=1
-- " Automatically start script
-- "let generate_tags=1
-- " Displays taglist results in a vertical window:
-- "let Tlist_Use_Horiz_Window=0
-- " Shorter commands to toggle Taglist display
-- "nnoremap TT :TlistToggle<CR>
-- "map <F4> :TlistToggle<CR>
-- " Various Taglist diplay config:
-- "let Tlist_Use_Right_Window = 1
-- "let Tlist_Compact_Format = 1
-- "let Tlist_Exit_OnlyWindow = 1
-- "let Tlist_GainFocus_On_ToggleOpen = 1
-- "let Tlist_File_Fold_Auto_Close = 1
-- 
-- "-------------------------------------------------------------------------------
-- " PYDOC
-- "-------------------------------------------------------------------------------
-- """ PYDOC path
-- " let g:pydoc_cmd=/usr/bin/pydoc
-- " ------------------------------------------------------------------------------
-- ====================== Ruff ======================
-- " ------------------------------------------------------------------------------
-- Code Format on <C-f> CTRL+F
vim.keymap.set('n', '<C-f>', function()
  vim.cmd('write')
  vim.fn.system('ruff format --quiet ' .. vim.fn.expand('%'))
  vim.cmd('edit!')
  print("Formatted with Ruff")
end, { desc = "Format with Ruff" })

vim.keymap.set('i', '<C-f>', '<Esc>:lua vim.fn.system("ruff format --quiet " .. vim.fn.expand("%")); vim.cmd("edit!")<CR>a', 
  { desc = "Format with Ruff" })
-- "-------------------------------------------------------------------------------
-- " RUST related
-- "-------------------------------------------------------------------------------
-- let g:rustfmt_autosave = 1


-- " ------------------------------------------------------------------------------
-- " Other settings
-- " ------------------------------------------------------------------------------
-- " colors
vim.cmd([[colorscheme darkmate]])
vim.opt.termguicolors = true
-- "Invisible character colors
-- highlight NonText guifg=#4a4a59
-- highlight SpecialKey guifg=#4a4a59
-- " enable highlight for vim-python/python-syntax plugin
vim.g.python_highlight_all = 1
vim.g.python_highlight_func_calls = 0
-- 
-- " insert empty lines in normal mode
vim.keymap.set('n', '<Enter>', 'o<ESC>')

-- " Bubble multiple lines in visual mode
vim.keymap.set('v', '<M-Down>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<M-Up>', ":m '<-2<CR>gv=gv")
-- " Bubble single lines
vim.keymap.set('n', '<M-Down>', ":m .+1<CR>==")
vim.keymap.set('n', '<M-Up>', ":m .-2<CR>==")
-- vim.keymap.set("i", "<M-Down>", ":m .+1<CR>==gi")
-- vim.keymap.set("i", "<M-Up>", ":m .-2<CR>==gi")

-- " Text indentation with Alt+Letf/Right and so on
vim.keymap.set('n', '<M-Left>', '<<')
vim.keymap.set('n', '<M-Right>', '>>')
vim.keymap.set('v', '<M-Left>', '<gv')
vim.keymap.set('v', '<M-Right>', '>gv')

-- " Visual
-- vim.opt.showmatch = true -- set showmatch  " Show matching brackets.
vim.opt.colorcolumn = "100"
-- """ Searching and Patterns
vim.opt.ignorecase = true -- Default to using case insensitive searches,
vim.opt.smartcase = true -- unless uppercase letters are used in the regex.
vim.opt.hlsearch = true -- Highlight searches by default.
vim.opt.incsearch = true -- Incrementally search while typing a /regex
 
-- """ Folding
vim.opt.foldmethod = "indent" -- By default, use syntax to determine folds
vim.opt.foldlevelstart = 99 -- All folds open by default
 
vim.opt.number = true -- Display line numbers
vim.opt.numberwidth = 1 -- using only 1 column (and 1 space) while possible
vim.opt.background = "dark"
 
-- """ Messages, Info, Status
-- set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
-- set confirm                 " Y-N-C prompt if closing with unsaved changes.
-- set showcmd                 " Show incomplete normal mode commands as I type.
-- set report=0                " : commands always print changed line count.
-- set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
-- set ruler                   " Show some info, even without statuslines.
-- set laststatus=2            " Always show statusline, even if only 1 window.
-- 
-- """ Tabs/Indent Levels
vim.opt.tabstop = 4 -- set tabstop=4          " <tab> inserts 4 spaces
vim.opt.shiftwidth = 4 -- set shiftwidth=4    " but an indent level is 2 spaces wide.
vim.opt.softtabstop = 4 -- set softtabstop=4  " <BS> over an autoindent deletes both spaces.
vim.opt.expandtab = true -- set expandtab     " Use spaces, not tabs, for autoindent/tab key.
vim.opt.shiftround = true -- set shiftround   " rounds indent to a multiple of shiftwidth
vim.opt.autoindent = true -- set autoindent   " Keep indentation level from previous line
vim.opt.textwidth = 99 -- set textwidth=99            " 

-- """ Command Line
vim.opt.history = 1000 -- set history=1000     " Keep a very long command-line history.
vim.opt.wildmenu = true -- set wildmenu        " Menu completion in command mode on <Tab>
vim.opt.wildmode = "full" -- set wildmode=full " <Tab> cycles between all matching choices.

-- """ Per-Filetype Scripts
-- " NOTE: These define autocmds, so they should come before any other autocmds.
-- "       That way, a later autocmd can override the result of one defined here.
-- filetype on                 " Enable filetype detection,
-- filetype indent on          " use filetype-specific indenting where available,
-- filetype plugin on          " also allow for filetype-specific plugins,
-- syntax on                   " and turn on per-filetype syntax highlighting.
-- 
-- """ OTHER SETTINGS
-- " set <leader> as ,
vim.g.mapleader = ","
-- " Empty highlight after search by leader - space
vim.keymap.set('n', '<leader><space>', ':noh<CR>')

-- " Execute file being edited with <Shift> + e:
-- map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>
-- 
-- " Shift+Insert will paste from system buffer (Control+C)
-- cmap <S-Insert>     <C-R>+
-- exe 'inoremap <script> <S-Insert>' paste#paste_cmd['i']
-- 
-- " CTRL+S saves the buffer
vim.keymap.set('n', '<C-s>', ':w<CR>')
 
-- " setup persisent undo
vim.opt.undofile = true
vim.opt.undodir = "/tmp"

-- " ignore following files
vim.opt.wildignore:append("*.bak,*~,*.tmp,*.backup,*.swp")

-- " close buffer
vim.keymap.set('n', '<leader>d', ':bp|bd #<CR>')

-- " %s/from/to interactive.
-- " could be split, nosplit
-- set inccommand=nosplit
-- 
-- " ------------------------------------------------------------------------------
-- " comments. select lines and press Alt + /
-- " ------------------------------------------------------------------------------
do
  local binding
  if vim.fn.has("macunix") == 1 then
    binding = '÷'
  elseif vim.fn.has("unix") == 1 then
    binding = '<M-/>'
  end

  local operator_rhs = function()
    return require('vim._comment').operator()
  end

  vim.keymap.set({ 'n', 'x' }, binding, operator_rhs, { expr = true, desc = 'Toggle comment' })

  local line_rhs = function()
    return require('vim._comment').operator() .. '_'
  end

  vim.keymap.set('n', binding, line_rhs, { expr = true, desc = 'Toggle comment line' })
end
-- "-------------------------------------------------------------------------------
-- " Tabstops by Language
-- "-------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"html", "htmldjango", "javascript", "typescript"},
  command = "setlocal ts=2 sts=2 sw=2 tw=0"
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"python", "lua"},
  command = "setlocal ts=4 sts=4 sw=4"
})

-- "-------------------------------------------------------------------------------
--- -- ====================== nvim-cmp ======================
-- "-------------------------------------------------------------------------------
local cmp = require('cmp')
local luasnip = require("luasnip")

-- Load all SnipMate snippets from plugins (e.g. honza/vim-snippets)
require("luasnip.loaders.from_snipmate").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  mapping = {
    ['<Up>']      = cmp.mapping.select_prev_item(),
    ['<Down>']    = cmp.mapping.select_next_item(),
    ['<C-b>']     = cmp.mapping.scroll_docs(-4),
    ['<C-f>']     = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>']     = cmp.mapping.abort(),
    -- ['<CR>']      = cmp.mapping.confirm({ select = true }),
    -- snippets confirm or confirm selection of completion
    ['<CR>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            if luasnip.expandable() then
                luasnip.expand()
            else
                cmp.confirm({
                    select = true,
                })
            end
        else
            fallback()
        end
    end),

    -- Jump by snippets with Tab
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),


    -- AI Completion triggered only with Alt+y
    ["<A-y>"] = require('minuet').make_cmp_map()
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer', keyword_length = 3 },
    { name = 'path' },
    -- AI source is NOT enabled by default → only triggered manually. 
    -- { name = 'minuet' },
  }),

  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip  = "[Snip]",
        buffer   = "[Buf]",
        path     = "[Path]",
        ai       = "[AI Qwen]",
      })[entry.source.name]
      return vim_item
    end,
  },
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = 'buffer' } }
})


local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Optional: Enhance capabilities with nvim-cmp
if pcall(require, 'cmp_nvim_lsp') then
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
end

-- Common on_attach function
local function on_attach(client, bufnr)
  local opts = { buffer = bufnr, silent = true }

  -- Disable semantic highlighting from BasedPyright
  client.server_capabilities.semanticTokensProvider = nil
  -- <leader>df Open floating diagnostic window = :lua vim.diagnostic.open_float()
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, opts)
end

-- ====================== Python ======================
-- pip install ruff
vim.lsp.config('ruff', {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    settings = {
      args = { "--max-line-length=100" },
    },
  },
})

-- pip install basedpyright or npm install basedpyright
vim.lsp.config('basedpyright', {   -- or 'pyright'
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", ".git" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",   -- "off", "basic", "standard", "strict", "recommended", "all"
        diagnosticMode = "openFilesOnly",  --"workspace"
        -- Disable common annoying warnings
        reportAny = false,
        reportUnknownVariableType = false,
        reportUnannotatedClassAttribute = false,
        reportUnknownMemberType = "none",
        reportUnusedImport = "none",
        reportUnusedVariable = "warning",
        reportIncompatibleVariableOverride = "none",
        reportUnannotatedClassAttribute = "none",
        reportPrivateImportUsage = "none",
        reportMissingImports = "warning",
      },
    },
  },
})

-- ====================== TypeScript / Angular / Ionic ======================
-- npm install -g @vtsls/language-server
vim.lsp.config('vtsls', {
  cmd = { "vtsls", "--stdio" },
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  root_markers = { "package.json", "tsconfig.json", ".git" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
      },
    },
  },
})

-- Diagnostics clean UI
vim.diagnostic.config({
  virtual_text = false,  --{ severity = vim.diagnostic.severity.ERROR },
  underline = false,
  signs = true,
  float = { border = "rounded" },
})

-- ====================== Enable the servers ======================
-- This tells Neovim to automatically start them when needed
vim.lsp.enable('ruff')
vim.lsp.enable('basedpyright')
vim.lsp.enable('vtsls')


-- ================== AI =====================
-- minuet
require('minuet').setup {
    provider = 'openai_fim_compatible',
    n_completions = 1, -- recommend for local model for resource saving
    -- I recommend beginning with a small context window size and incrementally
    -- expanding it, depending on your local computing power. A context window
    -- of 512, serves as an good starting point to estimate your computing
    -- power. Once you have a reliable estimate of your local computing power,
    -- you should adjust the context window to a larger value.
    context_window = 512,
    provider_options = {
        openai_fim_compatible = {
            -- For Windows users, TERM may not be present in environment variables.
            -- Consider using APPDATA instead.
            api_key = 'TERM',
            name = 'Ollama',
            end_point = 'http://localhost:11434/v1/completions',
            model = 'qwen2.5-coder:7b',
            optional = {
                max_tokens = 56,
                top_p = 0.9,
            },
        },
    },
}
