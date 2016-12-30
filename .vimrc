colorscheme turbo       " awesome colorscheme
syntax enable           " enable syntax processing

set tabstop=1           " number of visual spaces per TAB
set shiftwidth=4
set softtabstop=4       " number of spaces in tab when editing
set expandtab           " tabs are spaces
filetype plugin indent on " enable auto indent and filetype detection

set number              " show line numbers

set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching [{()}]
set cursorline          " highlight current line
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

set t_Co=256            " Use 256 colors

" turn off search highlight with <\> + <space>
nnoremap <leader><space> :nohlsearc<CR>
" use ' to go to endline instead of $
nnoremap ' $
onoremap ' $
vnoremap ' $
nnoremap $ <nop>
onoremap $ <nop>
vnoremap $ <nop>

" Enable mouse use in all modes
set mouse=a
