" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup

""""""""""""""""""""""""
" Ntem's Configuration "
""""""""""""""""""""""""

" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
 filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

colorscheme xoria256

" Custom settings "

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set encoding=utf-8

" =============== Pathogen Initialization ===============
" This loads all the plugins in ~/.vim/undle
" Use tpope's pathogen plugin to manage all other plugins
set nocp
runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()
execute pathogen#helptags()
call pathogen#incubate()
"call pathogen#infect()
"call pathogen#helptags()

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

if has('cmdline_info')
    set ruler                   " show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
    set showcmd                 " show partial commands in status line and
                                " selected
                                " characters/lines
                                " in visual
                                " mode
endif

set laststatus=2
" Broken down into easily includeable segments
set statusline=%<%f\   " Filename
set statusline+=%w%h%m%r " Options
"set statusline+=%{fugitive#statusline()} "  Git Hotness
set statusline+=\ [%{&ff}/%Y]            " filetype
set statusline+=\ [%{getcwd()}]          " current dir
set statusline+=\ [A=\%03.3b/H=\%02.2B] "ASCII / Hexadecimal value of char
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  "Right aligned file nav info


" ================ General Config ====================

let mapleader = ","
set number "Line numbers are good
set cursorline "Line to indicate the cursor location
set backspace=indent,eol,start "Allow backspace in insert mode
set mouse=a "Allow mouse in all modes
set clipboard=unnamed "Support for Mac OS X clipboard
set pastetoggle=<leader>pp
set history=1000 "Store lots of :cmdline history
set showcmd "Show incomplete cmds down the bottom
set showmode "Show current mode down the bottom
set gcr=a:blinkon0 "Disable cursor blink
set visualbell "No sounds
set autoread "Reload files changed outside vim
set cul

" Make backspace behave like other apps
set backspace=indent,eol,start


" When searching try to be smart about cases
set smartcase

"earching try to be smart about cases
"set smartcaseThis makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" ================ Search Settings =================

set incsearch "Find the next match as we type the search
set viminfo='100,f1 "Save up to 100 marks, enable capital marks
set hlsearch " highlight the search

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile


" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4

"filetype on " Enable filetype detection
filetype off
filetype plugin on
filetype indent on
filetype plugin indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap "Don't wrap lines
set linebreak "Wrap lines at convenient points

" Hightlight characters over 80th char
"highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
"match OverLength /\%>80v.\+/
set textwidth=81
"set colorcolumn=+1
"hi ColorColumn guibg=#2d2d2d ctermbg=246
let &colorcolumn=join(range(82,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="81,".join(range(999,999),",")

" ================ Folds ============================

set foldmethod=indent "fold based on indent
set foldnestmax=3 "deepest fold is 3 levels
set nofoldenable "dont fold by default


" ================ Completion =======================

set wildmode=list:longest
set wildmenu "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif


" ================ Scrolling ========================

set scrolloff=8 "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1



set nocompatible
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundles
Bundle 'gmarik/vundle'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'majutsushi/tagbar'
Bundle 'wincent/Command-T'
Bundle 'ervandew/supertab'
Bundle 'nvie/vim-flake8'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "davidhalter/jedi-vim"

augroup vimrc_autocmds
        autocmd!
            " highlight characters past column 120
            autocmd FileType python highlight Excess ctermbg=DarkGrey
            " guibg=Black
            autocmd FileType python match Excess /\%120v.*/
            autocmd FileType python set nowrap
augroup END

" Powerline setup
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

" NerdTree setup
autocmd vimenter * if !argc() | NERDTree | endif
map <Leader>k :NERDTreeToggle<CR>

"Python general

" autocmd FileType python compiler pylint
let python_highlight_all = 1
set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
set omnifunc=pythoncomplete#Complete
inoremap <Nul> <C-x><C-o>
autocmd BufWritePre *.py :%s/\s\+$//e

" Map invenio make install script
" nmap <D>b :VirtualEnvActivate invenio_next <CR> :let current_folder=expand('%:p:h') | invenio-make-install $(current_folder)

" Command-T mapping
nnoremap <silent> <Leader>t :CommandT<CR>

" Parenthesis, brackets etc
:inoremap ( ()<Esc>i
:inoremap [ []<Esc>i
:inoremap { {}<Esc>i
:inoremap " ""<Esc>i
:inoremap ' ''<Esc>i

" Highlight end of line whitespace.
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" Tagbar
nmap <Leader>l :TagbarToggle<CR>

" Flake8 -
autocmd FileType python map <buffer> <Leader>0 :call Flake8()<CR>
highlight link PyFlakes SpellBad

" Tags
set tags=./tags;

