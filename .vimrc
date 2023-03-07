" Allgemein
set number
set relativenumber
set mouse=a
set wildmenu
set wildignorecase
set laststatus=2

" Case insensitive, außer man gibt Großbuchstaben ein
" Kann mit \c im Suchstring wieder auf insensitve gestzt werden
set ignorecase
set smartcase

" Tabs, Whitespace, etc.
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
" set list

" Color
set background=dark
silent! colorscheme elflord
silent! colorscheme gruvbox

" netrw browser
let g:netrw_banner = 0
let g:netrw_winsize = 25

" Mapping mit ] ist mist...
nnoremap ü <C-]>

" Filebrowser & Suche
nnoremap ,E :Texplore<CR>
nnoremap ,e :Explore<CR>
nnoremap ,F :tabe **/*
nnoremap ,f :e **/*

" Suchergebnisse in der Mitte des Viewports 
nnoremap n nzz
nnoremap N Nzz

" Such-Highlighting
nnoremap <C-L> :nohl<CR>
