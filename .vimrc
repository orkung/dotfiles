""" Eklentiler
call plug#begin('~/.vim/plugged')
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'joom/turkish-deasciifier.vim'
Plug 'scrooloose/nerdtree'
Plug 'mhartington/oceanic-next'
Plug 'christoomey/vim-tmux-navigator'
Plug 'rbgrouleff/bclose.vim'
call plug#end()

""" Ayarlar
filetype on
filetype plugin on
filetype plugin indent on
filetype indent on

set nocompatible        " don't bother with vi compatibility
set autoread            " reload files when changed on disk, i.e. via `git checkout`
set tabstop=4           " tab uzunluğu
set shiftwidth=4        "Görsel modda < ve > karakterlerine basıldığında bloğun ne kadar kaydırılacağı
set softtabstop=4       "boşluklardan oluşan feyk tabın uzunluğu
set expandtab           "tab'a basıldığında boşluk karakterlerinden oluşan feyk tab kullanılmasını sağlar.
set lbr                 "linebreak; satir sonunda alt satira hecelemeyle gecisi saglar
set tw=79               "bir satırın alabileceği karakter sayısı
set magic               " For regular expressions turn magic on

set clipboard=unnamed
set term=tmux-256color

set pastetoggle=<F5>            "    when in insert mode, press <F5> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
au InsertLeave * set nopaste

""" Eklenti yapilandirma
" Buffergator; buffer'lar arasi gezinme
nnoremap <C-n> :BuffergatorMruCycleNext<cr>
nnoremap <C-p> :BuffergatorMruCyclePrev<cr>

" turkish-deasciifier; harflerdeki turkceye ozgu karakterlerin, kelimenin anlamina gore eklenip kaldirilmasini saglar.
vmap <Leader>tr :<c-u>call Turkish_Deasciify()<CR>
vmap <Leader>rt :<c-u>call Turkish_Asciify()<CR>
let g:turkish_deasciifier_path = '~/Git_Repolari/diger/turkish-deasciifier/turkish-deasciify'

""" Nerdtree dizin/dosya paneli
" Leader key ile acma
"" map <Leader>n :NERDTreeMapToggleHidden<CR>
map <Leader>n :NERDTreeToggle<CR>
" Sadece NERDTREE penceresi aciksa Vim'i otomatik kapat;
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeMapJumpNextSibling = ''
let g:NERDTreeMapJumpPrevSibling = ''
let g:NERDTreeMapJumpLastChild = ''
let g:NERDTreeMapJumpFirstChild = ''
let g:NERDTreeWinSize=31
let g:NERDTreeDirArrows=0
" vim-tmux-navigator; tmux pane'leri arasinda vim kisayollariyla gezinme
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

""" Görünüm
hi StatusLine cterm=none gui=none
hi StatusLineNC cterm=none gui=none
hi VertSplit ctermfg=00
hi SignColumn ctermbg=none

hi Search ctermfg=25 ctermbg=16
hi Folded ctermfg=25 ctermbg=16
hi NonText ctermfg=00
hi clear SignColumn
hi TabLineFill cterm=none gui=none
hi TabLine ctermfg=none ctermbg=none
hi TabLineSel ctermfg=none ctermbg=none
set statusline=%t\ %=\ %l:%c
set fillchars+=vert:│

"""" Window'u acik tut, buffer yonet
" buffer'i kaydet
nnoremap <Leader>w :w<bar>:Bclose!<cr>
" buffer'i kaydetme
nnoremap <Leader>q :Bclose!<cr>

" buffer'lari kaydet
noremap <Leader>s :wall<CR>
"noremap <Leader>e :wall<CR>

"""" Window'u kapatip buffer yonet
" buffer'i kaydet
noremap <S-w> :wqall!<CR>
" buffer'lari kaydetme
noremap <S-q> :bdelete!<cr>
noremap <S-e> :qall!<cr>

"colorscheme OceanicNext
"if exists('+termguicolors')
"  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"  set termguicolors
"endif
