" Vim color file
" Maintainer:	Ruggero Valli
" Last Change:	2016 10 September

hi clear
let colors_name = "turbo"

" Normal should come first
hi Normal     cterm=NONE ctermbg=NONE ctermfg=249 " Black LGrey

hi ErrorMsg   ctermfg=255 ctermbg=88    " White DRed
hi CursorLine cterm=bold  ctermbg=235   " DGrey
hi Search     ctermfg=186 ctermbg=22    " Yellow Green
hi Folded     ctermfg=3   ctermbg=17    " Yellow DBlue
hi FoldColumn ctermfg=3   ctermbg=17    " Yellow DBlue

hi Visual     cterm=reverse
hi IncSearch  cterm=reverse
hi MatchParen cterm=reverse

" syntax highlighting
hi Comment    cterm=NONE ctermfg=88     " DRed      #5f0000
hi Constant   cterm=NONE ctermfg=220    " Yellow    #ffd700
hi String     cterm=NONE ctermfg=22     " DGreen    #00d700
hi Identifier cterm=NONE ctermfg=87     " LBlue     #5fffff
hi Function   cterm=NONE ctermfg=202    " Orange    #ff5f00
hi Statement  cterm=NONE ctermfg=63     " DBlue     #5f5fff
hi Operator   cterm=NONE ctermfg=33     " Blue      #0087ff
hi PreProc    cterm=NONE ctermfg=24     " Turky     #ff00ff
hi Type	      cterm=NONE ctermfg=215    " LOrange   #ffaf5f
hi Special    cterm=NONE ctermfg=53     " Prugna    #5f005f
hi Todo       cterm=NONE ctermfg=88 ctermbg=255     " DRed White    


