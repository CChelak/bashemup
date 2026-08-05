" === Formatting ===

set cursorline
set number

" Setting tabs vs space specs for file types
autocmd FileType * set tabstop=2|set shiftwidth=2|set noexpandtab
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType lua set tabstop=2|set shiftwidth=2|set expandtab

" The mid-dot is only supported in utf-8
silent! set encoding=utf-8
if &encoding ==# 'utf-8'
  set listchars=tab:-->,space:·
else
  set listchars=tab:-->,space:.
endif
set list
set shellcmdflag=-ic
set nowrap

if (has("termguicolors"))
  set termguicolors
endif

if (has("xterm-true-color"))
  set xterm-true-color
endif

syntax enable

" This must come before the ColorColumn highlight m_definition
colorscheme desert

set colorcolumn=80,120
highlight ColorColumn ctermbg=14 guibg=lightyellow

" === Plugins ===

" Install plugins if vim-plug is present. Checking the file rather than
" plug#begin() -- autoload functions read as missing until first called.
if filereadable(expand('~/.vim/autoload/plug.vim'))
  call plug#begin()

  " For Dockerfile syntax highlighting
  Plug 'ekalinin/Dockerfile.vim'

  " Getting a source tree to the side
  Plug 'preservim/nerdtree'

  call plug#end()

  " --- Plugin shortcuts ---

  " Type '\nt' to toggle the tree
  map <Leader>nt :NERDTreeToggle<CR>
else
  echomsg 'vim-plug not installed: please install, then :PlugInstall'
endif
