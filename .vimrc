" Vimrc file
" Maintainer:   Ruggero Valli
" Last Change:  2017 6 October
" Credits:      Ruggero Valli <ruggerovalli@gmail.com>

" =========== General =========== {{{

set nocompatible        " disable Vi compatibility
colorscheme turbo       " awesome colorscheme
syntax enable           " enable syntax processing

set tabstop=4           " number of visual spaces per TAB
set shiftwidth=4
set softtabstop=4       " number of spaces in tab when editing
set expandtab           " tabs are spaces
filetype plugin indent on " enable auto indent and filetype detection

set number              " show line numbers
set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching [{()}]
set cursorline          " highlight current line
set incsearch           " search as characters are entered
set hlsearch            " highlight last search
set showcmd             " show partial commands
set foldmethod=marker   " fold using three braces as a marker 
set foldcolumn=1        " show the folds on the left column

set t_Co=256            " Use 256 colors
"}}}

" =========== Mappings =========== {{{

" Set the leader character for mappings
let mapleader = "-"
let maplocalleader = "-"

" turn off search highlight with <leader> + <space>
nnoremap <leader><space> :nohlsearc<CR>

" use ' to go to endline instead of $
nnoremap ' $
onoremap ' $
vnoremap ' $
nnoremap $ <Nop>
onoremap $ <Nop>
vnoremap $ <Nop>

" Enable mouse use in all modes
set mouse=a

" map to open vimrc fast and reload it
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :w<CR>:source $MYVIMRC<CR>:nohlsearch<CR>

" eliminate arrow keys
inoremap  <Up>     <Nop>
inoremap  <Down>   <Nop>
inoremap  <Left>   <Nop>
inoremap  <Right>  <Nop>
noremap   <Up>     <Nop>
noremap   <Down>   <Nop>
noremap   <Left>   <Nop>
noremap   <Right>  <Nop>

" <Esc> becomes jk
inoremap jk <Esc>
"inoremap <Esc> <Nop>   " Not suggested because breaks 
                        " arrow keys in insert mode.
"}}}
                        
" =========== Language Related ==========="{{{

" Complete parenthesis
inoremap " ""<Esc>i
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
" example:
" int main(){
"   <-- cursor
" }
inoremap {<CR> {<CR>}<Esc>ko
" VERY useful mapping that moves the cursor after the next parenthesis
inoremap <C-A> <Esc>/[)}"'\]>]<CR>:nohlsearch<CR>a

" Comment Line
nnoremap <leader>h :call Comment('n')<CR>
" Comment Region
vnoremap <leader>h :call Comment('v')<CR>
" Uncomment Line
nnoremap <leader>u :call Uncomment('n')<CR>
" Uncomment Region
vnoremap <leader>u :call Uncomment('v')<CR>
" Add semicolon
nnoremap <leader>, mpA;<Esc>`p
" Save, Compile and Run current file
nnoremap <leader>cr :call CompileNRun()<Cr>

augroup buffer_load
    autocmd!
    autocmd BufRead,BufNewFile,BufWrite * :call Set_symbols()
augroup END

"}}}

" ============= Functions ============= {{{

function! Set_symbols()
    " Set the symbol used for commenting and commands to run files
    if &filetype ==# 'vim'
        let b:comment_symbol = '" '
        let b:cr_string = "source %"
    elseif &filetype ==# 'python'
        let b:comment_symbol = '#'
        let b:cr_string = "!python3 %"
    elseif &filetype ==# 'c'
        let b:comment_symbol = '//'
        let b:cr_string = "!gcc % -o %:r -lm && ./%:r"
    elseif &filetype ==# 'javascript'
        let b:comment_symbol = '//'
    elseif &filetype ==# 'go'
        let b:comment_symbol = '//'
        let b:cr_string = "!go run %"
    elseif &filetype ==# 'java'
        let b:comment_symbol = '//'
    endif
endfunction

function! Comment(mode)
    " Used in mappings to comment lines for different languages
    " If mode is 'n' (normal), comment only current line
    " If mode is 'v' (visual), comment all selected lines
    if a:mode ==# 'n'
        exec ":normal! mp0I" . b:comment_symbol . "\<Esc>`p"
    elseif a:mode ==# 'v'
        exec ":normal! mp0\<C-V>I" . b:comment_symbol . "\<Esc>`p"
    endif
endfunction

function! Uncomment(mode)
    " Used in mappings to uncomment lines for different languages
    " If mode is 'n' (normal), uncomment only current line
    " If mode is 'v' (visual), uncomment all selected lines
    if a:mode ==# 'n'
        exec ":s/" . escape(b:comment_symbol, '/') . "//e"
    elseif a:mode ==# 'v'
        exec ":'<,'>s/" . escape(b:comment_symbol, '/') . "//e"
    endif
endfunction

function! CompileNRun()
    " Used in mappings to save, compile and run the current file
    " For many languages.
    exec "w" 
    exec b:cr_string
endfunction 

"}}}

" ============= HexMode ============= {{{

nnoremap <leader>x :Hexmode<CR>
inoremap <leader>x <Esc>:Hexmode<CR>
vnoremap <leader>x :<C-U>Hexmode<CR>


" ex command for toggling hex mode - define mapping if desired
command! Hexmode call ToggleHex())

" helper function to toggle hex mode
function! ToggleHex()
    " hex mode should be considered a read-only operation
    " save values for modified and read-only for restoration later,
    " and clear the read-only flag for now
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1
    if !exists("b:editHex") || !b:editHex
        " save old options
        let b:oldft=&ft
        let b:oldbin=&bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        silent :e  " this will reload the file without trickeries 
        " (DOS line endings will be shown entirely )
        let &ft="xxd"
        " set status
        let b:editHex=1
        " switch to hex editor
        %!xxd -u -g 1
    else
        " restore old options
        let &ft=b:oldft
        if !b:oldbin
            setlocal nobinary
        endif
        " set status
        let b:editHex=0
        " return to normal editing
        %!xxd -r
    endif
    " restore values for modified and read only state
    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfunction
"}}}
