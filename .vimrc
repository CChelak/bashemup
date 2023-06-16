" === Miscellaneous ===

set cursorline

" Setting tabs vs space specs for file types
autocmd FileType * set tabstop=2|set shiftwidth=2|set noexpandtab
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab

set listchars=tab:-->,space:·
set list
set shellcmdflag=-ic

if (has("termguicolors"))
  set termguicolors
endif

if (has("xterm-true-color"))
  set xterm-true-color
endif

syntax enable

" === Plugins ===

" Install and use plugins with Vim Plug
call plug#begin()

" For Dockerfile syntax highlighting
Plug 'ekalinin/Dockerfile.vim'

" Getting a source tree to the side
Plug 'preservim/nerdtree'

call plug#end()

" --- Plugin shortcuts ---

" Type '\nt' to toggle the tree
map <Leader>nt :NERDTreeToggle<CR>
