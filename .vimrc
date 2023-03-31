" Allgemein
set nocompatible            " Kein VI Mode
set number                  " Zeilennummern
set relativenumber          " Relative Zeilennummern
set mouse=a                 " Maus aktivieren
set wildmenu                " <tab> zeigt Matches als Menü
set wildignorecase          " Case insensitiv ^
set laststatus=2            " Statuszeile immer an

" Case insensitive bei Suche, außer man gibt Großbuchstaben ein
" Kann mit \c im Suchstring wieder auf insensitve gestzt werden
set ignorecase
set smartcase

" Tabs, Whitespace, etc.
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab
silent! set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
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
