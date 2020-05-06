""" Eklentiler
call plug#begin('~/.vim/plugged')
Plug 'joom/turkish-deasciifier.vim'
Plug 'scrooloose/nerdtree'
Plug 'mhartington/oceanic-next'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

""" Ayarlar
filetype plugin on
filetype plugin indent on
filetype indent on

set clipboard=unnamed
set tabstop=4 " tab uzunluğu
set term=tmux-256color
set shiftwidth=4 "Görsel modda < ve > karakterlerine basıldığında bloğun ne kadar kaydırılacağı
set softtabstop=4 "boşluklardan oluşan feyk tabın uzunluğu
set expandtab "tab'a basıldığında boşluk karakterlerinden oluşan feyk tab kullanılmasını sağlar.
set lbr "linebreak; satir sonunda alt satira hecelemeyle gecisi saglar
set tw=79 "bir satırın alabileceği karakter sayısı

""" Eklenti yapilandirma

" turkish-deasciifier; harflerdeki turkceye ozgu karakterlerin, kelimenin anlamina gore eklenip kaldirilmasini saglar.
vmap <Leader>tr :<c-u>call Turkish_Deasciify()<CR>
vmap <Leader>rt :<c-u>call Turkish_Asciify()<CR>
let g:turkish_deasciifier_path = '~/Git_Repolari/diger/turkish-deasciifier/turkish-deasciify'

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

"colorscheme OceanicNext
"if exists('+termguicolors')
"  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"  set termguicolors
"endif
