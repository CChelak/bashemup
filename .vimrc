set cursorline

" Setting tabs vs space specs for file types
autocmd FileType * set tabstop=2|set shiftwidth=2|set noexpandtab
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab

set listchars=tab:-->,space:·
set list
set tags+=~/tags/osgeo_tags
set shellcmdflag=-ic

if (has("termguicolors"))
  set termguicolors
endif

if (has("xterm-true-color"))
  set xterm-true-color
endif

syntax enable


