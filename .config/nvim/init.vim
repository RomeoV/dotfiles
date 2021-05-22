""""" General settings """""
set autowrite              " Save before switching files
set undofile               " Undo after reopening file
set noswapfile             " Disable swap file
set scrolloff=5            " Scroll before reaching bottom/side
set sidescrolloff=4
set ignorecase
"set incsearch
set smartcase              " set ignorecase  " Ignore case when searching
set showmatch              " Show matching parentheses
set inccommand=nosplit     " Show effects of commands as you type
set number                 " Show lines distance to other lines
set relativenumber
set visualbell             " Blink on error
set tabstop=2              " Make tab 2 spaces wide
set shiftwidth=2           " Shift by 2 spaces when indenting
set expandtab              " Replace tabs by spaces
set smartindent            " Indent properly when starting new line
set nowrap                 " Don't wrap lines after 80 chars
set splitbelow             " Split new window below or right
set splitright
set backup                 " Create backups
set backupdir=~/.config/nvim/backup
set clipboard+=unnamedplus " Use system clipboard
set lazyredraw             " Don't redraw when execing macros
set foldlevelstart=20
set foldmethod=indent
set colorcolumn=80
"set cmdheight=2            " More space for messages

let mapleader = "\<Space>"             " Map leader to spacebar
noremap <leader>e :tabnew $MYVIMRC<CR> " Shortcut to edit init.vim
nmap <leader>/ :noh<CR>            " Clear search highlighting
"tnoremap <Esc> <C-\><C-n>         " Escape escapes terminal

""""" Plugins """""
" Install vim-plug if not available
if has('nvim')
    let g:vim_plug_dir = $HOME.'/.config/nvim'
else
    let g:vim_plug_dir = $HOME.'/.vim'
endif
if !isdirectory(g:vim_plug_dir)
    call mkdir(g:vim_plug_dir, 'p')
endif
if !filereadable(g:vim_plug_dir.'/autoload/plug.vim')
    execute '!git clone git://github.com/junegunn/vim-plug '
                \ shellescape(g:vim_plug_dir.'/autoload', 1)
endif

call plug#begin('~/.vim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Install fzf
Plug 'junegunn/fzf.vim'                                           " Use fuzzy finder, eg :Files
Plug 'junegunn/vim-peekaboo'                                      " See buffers
Plug 'junegunn/vim-easy-align'                                    " Align lines
Plug 'junegunn/seoul256.vim'                                      " Colorscheme
Plug 'morhetz/gruvbox'
Plug 'junegunn/limelight.vim'                                     " Concentration mode
Plug 'SirVer/ultisnips'                                           " Snippet manager
Plug 'honza/vim-snippets'                                         " Snippet compilation
Plug 'Shougo/deoplete.nvim'                                       " Autocompletion engine
" Plug 'zchee/deoplete-clang'                                       " Clang integration?
Plug 'ludovicchabant/vim-gutentags'                               " Automatically generate tag files.
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'                                         " Many git commands
Plug 'tpope/vim-unimpaired'                                       " ]<space> for new line etc
Plug 'tpope/vim-surround'                                         " delete/change in surrounding ()
Plug 'tpope/vim-commentary'                                       " gc to toggle comments
Plug 'tpope/vim-dispatch'                                         " :Make for better make
Plug 'tpope/vim-vinegar'                                          " Press '-' for file browser
Plug 'tpope/vim-repeat'                                           " Repeat more
Plug 'tpope/vim-sleuth'                                           " Repeat more
Plug 'lervag/vimtex'                                              " Many usefull Latex commands (eg compile and view)
Plug 'justinmk/vim-sneak'                                         " Add s<key><key> to zoom across file
Plug 'unblevable/quick-scope'
Plug 'easymotion/vim-easymotion'
Plug 'kassio/neoterm'                                             " Provides useful terminal commands.
Plug 'luochen1990/rainbow'
"Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'
Plug 'suan/vim-instant-markdown'
Plug 'plasticboy/vim-markdown'
Plug 'shime/vim-livedown'
" Plug 'prabirshrestha/async.vim'
" Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'dbgx/lldb.nvim', {'for': 'cpp'}
Plug 'rhysd/devdocs.vim'
Plug 'daeyun/vim-matlab'
Plug '907th/vim-auto-save'
Plug 'jeetsukumaran/vim-pythonsense'                                            " Python text objects
Plug 'easymotion/vim-easymotion'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'takac/vim-hardtime'

call plug#end()

"""""" Plugin configuration """"""
" colo seoul256        " Use colorscheme
let g:gruvbox_contrast_dark='medium'
colorscheme gruvbox
set background=dark

" LSP config
lua << EOF
require'lspconfig'.pyright.setup{}
EOF

" Config fzf.
noremap <leader>b :Buffers<CR>
noremap <leader>B :Buffers<CR><CR>
noremap <leader>f :Files<CR>
noremap <leader>h :Helptags<CR>
noremap <leader>s :Snippets<CR>
noremap <leader>x :Commands<CR>
noremap <leader>m :Maps<CR>

"au TermClose * nested call OnTermClose()

" Config gutentags
let g:gutentags_ctags_tagfile=".tags"
" Config deoplete
let g:deoplete#enable_at_startup = 0
"autocmd InsertLeave * if pumvisible() == 0 | pclose | endif
let g:LanguageClient_autoStart = 1
let g:LanguageClient_selectionUI = "fzf"
" let g:LanguageClient_changeThrottle = 4
" let g:LanguageClient_hoverPreview="Never"
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_diagnosticsList = "Disabled"
" nnoremap <leader>lca :let g:LanguageClient_diagnosticsEnable=1
" nnoremap <leader>lcd :let g:LanguageClient_diagnosticsEnable=0

" Config RainbowParantheses
let g:rainbow_active = 0

" Config AutoSave
let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged"]

" Config python runtime for neovim
"let g:python3_host_prog='/home/romeo/anaconda3/bin/python'
"let g:python2_host_prog='/usr/bin/python2'

set hidden
" Config Language Server
let g:LanguageClient_serverCommands = {
    \ 'cpp': ['clangd'],
    \ 'python': ['pyls'],
    \ 'rust': ['rls'],
    \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
vnoremap <F5> :call LanguageClient_contextMenu()<CR>

" Config Devdocs
nmap K <Plug>(devdocs-under-cursor)

" Config neoterm
let g:neoterm_size=8
let g:neoterm_default_mod="botright"
let g:neoterm_autoinsert=1
" let g:neoterm_direct_open_repl=1
let g:neoterm_repl_python="ipython"
let g:neoterm_autoscroll=1
let g:neoterm_auto_repl_cmd=1
let g:neoterm_automap_keys=""
nmap <leader>\ <Plug>(neoterm-repl-send)
vmap <leader>\ <Plug>(neoterm-repl-send)
nmap <leader>\l <Plug>(neoterm-repl-send-line)
nmap <leader>\f :TREPLSendFile<CR>

" Config tagbar
let g:tagbar_autofocus=1
let g:tagbar_autoopen=1
let g:tagbar_autoclose=1
nmap <leader>to :TagbarOpen<CR>
nmap <leader>tc :TagbarClose<CR>
nmap <leader>tt :TagbarToggle<CR>

" Config vimtex
let g:vimtex_view_general_viewer = 'evince'
let g:vimtex_quickfix_mode=0
let g:tex_flavor = 'latex'

" Config terminal in general 
" Escape escapes terminal mode.
tnoremap <Esc> <C-\><C-n>
" Window mappings for terminal mode.
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
tnoremap <C-w>o <C-\><C-n><C-w>o
tnoremap <C-w>c <C-\><C-n><C-w>c
tnoremap <C-w>s <C-\><C-n><C-w>s
tnoremap <C-w>v <C-\><C-n><C-w>v

au VimEnter,BufRead,BufNewFile *.jl set filetype=julia
let g:latex_to_unicode_tab=1
