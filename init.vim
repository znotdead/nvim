set nocompatible               " be iMproved
" -------
" Plugins
" -------
call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-unimpaired'
Plug 'leafgarland/typescript-vim'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/TaskList.vim'
Plug 'SirVer/ultisnips'
Plug 'znotdead/vim-snippets'
Plug 'rstacruz/sparkup'
Plug 'scrooloose/syntastic'
Plug 'fs111/pydoc.vim'
Plug 'bling/vim-airline'
Plug 'jmcantrell/vim-virtualenv'
Plug 'tpope/vim-fugitive'
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
" Language Server Client
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" (Completion plugin option 1)
" Plug 'roxma/nvim-completion-manager'
" (Completion plugin option 2)
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

call plug#end()

" ------------------------------------------------------------------------------
" Virtualenv
" ------------------------------------------------------------------------------
" :VirtualEnvActivate
" :VirtualEnvDeactivate

" ------------------------------------------------------------------------------
" Pydoc
" ------------------------------------------------------------------------------
" ,pw - show docs for word
" ,pk - search by keyword
" :Pydoc <module>

" ------------------------------------------------------------------------------
" Syntastic
" ------------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--max-line-length=100'

" ------------------------------------------------------------------------------
" Airline settings
" ------------------------------------------------------------------------------
let g:airline_powerline_fonts = 1
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
let g:airline_theme = 'dark'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#left_sep = '|'
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = '|'
let g:airline#extensions#tabline#right_alt_sep = '|'
"nmap <M-1> <Plug>AirlineSelectTab1
"nmap <M-2> <Plug>AirlineSelectTab2
"nmap <M-3> <Plug>AirlineSelectTab3
"nmap <M-4> <Plug>AirlineSelectTab4
"nmap <M-5> <Plug>AirlineSelectTab5
"nmap <M-6> <Plug>AirlineSelectTab6
"nmap <M-7> <Plug>AirlineSelectTab7
"nmap <M-8> <Plug>AirlineSelectTab8
"nmap <M-9> <Plug>AirlineSelectTab9
nmap <M-,> <Plug>AirlineSelectPrevTab
nmap <M-.> <Plug>AirlineSelectNextTab
let g:airline_extensions = ['syntastic', 'tabline']

" ------------------------------------------------------------------------------
" UltiSnips
" ------------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file

" ------------------------------------------------------------------------------
" Sparkup
" ------------------------------------------------------------------------------
" Ctrl+E, Ctrl+n

" ------------------------------------------------------------------------------
" Deoplete
" ------------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1

" ------------------------------------------------------------------------------
" NERDTree Settings
" ------------------------------------------------------------------------------
" Hide python cache files (.pyc) in NERDTree
let NERDTreeIgnore=['\.pyc']
" open NERDTree with start directory
nnoremap <F9> :NERDTreeToggle ~/projects/<CR>
let NERDTreeShowBookmarks=1
" automatically open NERDtree
autocmd vimenter * NERDTree

"-------------------------------------------------------------------------------
" unimpaired
"-------------------------------------------------------------------------------
" Text movimg with plugin unimpaired.vim
" Bubble single lines

nmap <M-Up> [e
nmap <M-Down> ]e

" Bubble multiple lines
vmap <M-Up> [egv
vmap <M-Down> ]egv

" ------------------------------------------------------------------------------
" Other settings
" ------------------------------------------------------------------------------
" colors
colorscheme darkmate
set termguicolors
"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" insert empty lines in normal mode
nnoremap <Enter> o<ESC>

" Text indentation with Alt+Letf/Right and so on
nnoremap <M-Left> <<
nnoremap <M-Right> >>
vmap <M-Left> <gv
vmap <M-Right> >gv
nnoremap <M-h> <<
nnoremap <M-l> >>
vmap <M-h> <gv
vmap <M-l> >gv

" Visual
set showmatch  " Show matching brackets.

set colorcolumn=100
""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

""" Folding
set foldmethod=indent       " By default, use syntax to determine folds
set foldlevelstart=99       " All folds open by default

set number                  " Display line numbers
set numberwidth=1           " using only 1 column (and 1 space) while possible
set background=dark

""" Messages, Info, Status
set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.

""" Tabs/Indent Levels
set tabstop=4               " <tab> inserts 4 spaces
set shiftwidth=4            " but an indent level is 2 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set autoindent              " Keep indentation level from previous line
set textwidth=99            " 

""" Command Line
set history=1000            " Keep a very long command-line history.
set wildmenu                " Menu completion in command mode on <Tab>
set wildmode=full           " <Tab> cycles between all matching choices.

""" Per-Filetype Scripts
" NOTE: These define autocmds, so they should come before any other autocmds.
"       That way, a later autocmd can override the result of one defined here.
filetype on                 " Enable filetype detection,
filetype indent on          " use filetype-specific indenting where available,
filetype plugin on          " also allow for filetype-specific plugins,
syntax on                   " and turn on per-filetype syntax highlighting.

""" OTHER SETTINGS
" set <leader> as ,
let mapleader = ","
" Empty highlight after search by leader - space
nnoremap <leader><space> :noh<cr>

" Execute file being edited with <Shift> + e:
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>

" Shift+Insert will paste from system buffer (Control+C)
cmap <S-Insert>     <C-R>+
exe 'inoremap <script> <S-Insert>' paste#paste_cmd['i']

" CTRL+S saves the buffer
nmap <C-s> :w<CR>

" CTRL+F format python with YAPF
map <C-F> :call yapf#YAPF()<cr>
imap <C-F> <c-o>:call yapf#YAPF()<cr>

" setup persisent undo
if has("undofile")
    set undofile
    set undodir=/tmp
endif

" ignore following files
set wildignore+=*.bak,*~,*.tmp,*.backup,*.swp

" close buffer
nmap <silent> <leader>d :bp\|bd #<CR><CR>

" %s/from/to interactive.
" could be split, nosplit
set inccommand=nosplit

"-------------------------------------------------------------------------------
" Tagbar
"-------------------------------------------------------------------------------

nmap <F8> :TagbarToggle<CR>

"-------------------------------------------------------------------------------
" Taglist
"-------------------------------------------------------------------------------
" Taglist variables
" Display function name in status bar:
"let g:ctags_statusline=1
" Automatically start script
"let generate_tags=1
" Displays taglist results in a vertical window:
"let Tlist_Use_Horiz_Window=0
" Shorter commands to toggle Taglist display
"nnoremap TT :TlistToggle<CR>
"map <F4> :TlistToggle<CR>
" Various Taglist diplay config:
"let Tlist_Use_Right_Window = 1
"let Tlist_Compact_Format = 1
"let Tlist_Exit_OnlyWindow = 1
"let Tlist_GainFocus_On_ToggleOpen = 1
"let Tlist_File_Fold_Auto_Close = 1

"-------------------------------------------------------------------------------
" PYDOC
"-------------------------------------------------------------------------------
""" PYDOC path
" let g:pydoc_cmd=/usr/bin/pydoc

"-------------------------------------------------------------------------------
" Language Server
"-------------------------------------------------------------------------------
"let g:LanguageClient_serverCommands = {
"    \ 'python': ['pyls', '-v'],
"    \ }
"-------------------------------------------------------------------------------
" Tabstops by Language
"-------------------------------------------------------------------------------
autocmd Filetype html setlocal ts=2 sts=2 sw=2 tw=0
autocmd Filetype htmldjango setlocal ts=2 sts=2 sw=2 tw=0
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 tw=0
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2 tw=0
autocmd Filetype python setlocal ts=4 sts=4 sw=4
"-------------------------------------------------------------------------------
" Fuzzy Finder
"-------------------------------------------------------------------------------
nnoremap <silent> <M-o> :FZF<CR>
vnoremap <silent> <M-o> :FZF<CR>
"-------------------------------------------------------------------------------
" Rip Grep with Fuzzy Finder
"-------------------------------------------------------------------------------
" Example: :Rg <smth> - find one mention in file
" Example: :Rga <smth> - find all mentions
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'export RIPGREP_CONFIG_PATH="./.ripgreprc" && rg --column --max-count=1 --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* Rga
  \ call fzf#vim#grep(
  \   'export RIPGREP_CONFIG_PATH="./.ripgreprc" && rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
