" BASH_CONFIG
syntax enable
set modeline
set modelines=2
set nohlsearch
set foldenable
set foldmethod=marker
set termguicolors

" FOR OSX
  " set clipboard=unnamedplus
" FOR LINUX
set clipboard=unnamedplus
set nohlsearch
set number
set showmatch
set smartcase
set wildmode=longest,list
set wildignore+=*/.idea/*
set wildignore+=*/.git/*
set wildignore+=*/.svn/*
set wildignore+=*/vendor/*
set wildignore+=*/node_modules/*
set diffopt+=iwhite
set expandtab
set foldlevelstart=20
set hidden
set linebreak
set listchars=tab:——,trail:_
set modelines=1
set mouse=a
set autoindent
set backspace=indent,eol,start
set path+=**
set scrolloff=5
set shiftwidth=2
set shortmess+=c
set sidescrolloff=5
set smartindent
set splitbelow
set splitright
set synmaxcol=500
set tabstop=2
set textwidth=0
set timeoutlen=300
set updatetime=300
set wrapmargin=0
set encoding=utf-8
set cmdheight=2
set signcolumn=yes
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
silent set viewoptions
set showmode
set cursorline
set incsearch
set whichwrap=b,s,h,l,<,>,[,]
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

let mapleader=","
set autochdir
inoremap <C-Space> <C-x><C-o>

nnoremap ; :

