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
set cmdheight=2            " More space for messages

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

Plug 'lotabout/skim.vim'
Plug 'junegunn/vim-peekaboo'                                      " See buffers
Plug 'junegunn/vim-easy-align'                                    " Align lines
Plug 'morhetz/gruvbox'
Plug 'SirVer/ultisnips'                                           " Snippet manager
Plug 'honza/vim-snippets'                                         " Snippet compilation
Plug 'Shougo/deoplete.nvim'                                       " Autocompletion engine
Plug 'ludovicchabant/vim-gutentags'                               " Automatically generate tag files.
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'                                         " Many git commands
Plug 'tpope/vim-unimpaired'                                       " ]<space> for new line etc
Plug 'tpope/vim-surround'                                         " delete/change in surrounding ()
Plug 'tpope/vim-commentary'                                       " gc to toggle comments
Plug 'tpope/vim-dispatch'                                         " :Make for better make
Plug 'tpope/vim-vinegar'                                          " Press '-' for file browser
Plug 'tpope/vim-repeat'                                           " Repeat more
Plug 'lervag/vimtex'                                              " Many usefull Latex commands (eg compile and view)
Plug 'unblevable/quick-scope'
Plug 'easymotion/vim-easymotion'
Plug 'kassio/neoterm'                                             " Provides useful terminal commands.
Plug 'godlygeek/tabular'
" Plug 'suan/vim-instant-markdown'
Plug 'plasticboy/vim-markdown'
Plug 'rhysd/devdocs.vim'
Plug '907th/vim-auto-save'
Plug 'jeetsukumaran/vim-pythonsense'                                            " Python text objects
Plug 'JuliaEditorSupport/julia-vim'
Plug 'kdheepak/JuliaFormatter.vim'
Plug 'takac/vim-hardtime'

Plug 'nvim-lua/plenary.nvim'
Plug 'TimUntersberger/neogit'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

call plug#end()

"""""" Plugin configuration """"""
" colo seoul256        " Use colorscheme
let g:gruvbox_contrast_dark='medium'
colorscheme gruvbox
set background=dark

" Config fzf.
noremap <leader>b :Buffers<CR>
noremap <leader>B :Buffers<CR><CR>
noremap <leader>f :Files<CR>
noremap <leader>h :Helptags<CR>
noremap <leader>s :Snippets<CR>
noremap <leader>x :Commands<CR>
noremap <leader>m :Maps<CR>

let g:gutentags_ctags_tagfile=".tags"
" Config AutoSave
let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged"]

" Config python runtime for neovim
let g:python3_host_prog='/home/romeo/miniconda3/bin/python'
"let g:python2_host_prog='/usr/bin/python2'

" Config Devdocs
nmap K <Plug>(devdocs-under-cursor)

" Config neoterm
let g:neoterm_size=8
let g:neoterm_default_mod="botright"
let g:neoterm_autoinsert=1
" let g:neoterm_direct_open_repl=1
let g:neoterm_repl_python="ipython --no-autoindent"
let g:neoterm_autoscroll=1
let g:neoterm_auto_repl_cmd=1
let g:neoterm_automap_keys=""
nmap <leader>\ <Plug>(neoterm-repl-send)
vmap <leader>\ <Plug>(neoterm-repl-send)
nmap <leader>\l <Plug>(neoterm-repl-send-line)
nmap <leader>\b :TREPLSendFile<CR>
nmap <leader>\f :Texec include("%")<CR>
nmap <leader>\g :Texec go\ run\ "%"<CR>

" Config tagbar
let g:tagbar_autofocus=1
let g:tagbar_autoopen=1
let g:tagbar_autoclose=1
nmap <leader>to :TagbarOpen<CR>
nmap <leader>tc :TagbarClose<CR>
nmap <leader>tt :TagbarToggle<CR>

" Config vimtex
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_quickfix_mode=0
let g:tex_flavor = 'latex'
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : '',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \   '-shell-escape',
    \ ],
    \}

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
let g:JuliaFormatter_use_sysimage=1
let g:latex_to_unicode_tab=1

" Configure treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "cpp", "julia"},
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  -- textobjects = {
  --   select = {
  --     enable = true,

  --     -- Automatically jump forward to textobj, similar to targets.vim
  --     lookahead = true,

  --     keymaps = {
  --       -- You can use the capture groups defined in textobjects.scm
  --       ["af"] = "@function.outer",
  --       ["if"] = "@function.inner",
  --       ["ac"] = "@class.outer",
  --       ["ic"] = "@class.inner",
  --       ["ac"] = "@block.outer",
  --       ["ic"] = "@block.inner",
  --     },
  --   },
  --   move = {
  --     enable = true,
  --     set_jumps = true, -- whether to set jumps in the jumplist
  --     goto_next_start = {
  --       ["]f"] = "@function.outer",
  --       ["]]"] = "@scopename.inner",
  --     },
  --     goto_next_end = {
  --       ["]F"] = "@function.outer",
  --       ["]["] = "@scopename.inner",
  --     },
  --     goto_previous_start = {
  --       ["[f"] = "@function.outer",
  --       ["[["] = "@scopename.inner",
  --     },
  --     goto_previous_end = {
  --       ["[F"] = "@function.outer",
  --       ["[]"] = "@scopename.inner",
  --     },
  --   },
  -- },
}
EOF
