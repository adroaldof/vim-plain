" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" YAVF
"
" This is a high opinionated `.vimrc` file
" Use it as starting point to your own configurations
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

set nocompatible                " Make Vim don't worry about Vi options
let mapleader=","               " Change leader to a comma


" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Cursor Mode Settings
"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

let &t_SI.="\e[5 q"             " SI = INSERT mode
let &t_SR.="\e[4 q"             " SR = REPLACE mode
let &t_EI.="\e[1 q"             " EI = NORMAL mode (ELSE)


" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" General Configurations
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

set backspace=indent,eol,start  " Allow backspace in insert mode
set number                      " Line numbers are good
set relativenumber              " Set relative numbers to vim
set history=1000                " Store lots of :cmdline history
set showcmd                     " Show incomplete commands down the bottom
set showmode                    " Show current mode down the bottom
set gcr=a:blinkon0              " Disable cursor blink
set visualbell                  " No sounds
set autoread                    " Reload files changed outside vim
set nrformats=                  " Set decimals numbers as default
set hidden                      " Hide buffers from editor window
set nostartofline               " Stop certain movements from always going to the first char of a line
set confirm                     " Raise a dialog instead of failing a command
set showmatch                   " Show the matching brackets
set lazyredraw                  " Redraw screen only when it is needed


" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Cursor
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

set cursorline
hi CursorLine cterm=NONE ctermbg=242
hi CursorLineNr cterm=NONE ctermbg=Yellow ctermfg=Black gui=bold guibg=white


" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" General Configurations
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

set spell spelllang=en_us       " Set spell checker
hi SpellBad cterm=underline gui=undercurl ctermbg=NONE


" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Indentation
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

set nowrap                      " Don't wrap lines
set linebreak                   " Wrap lines at convenient points
set autoindent                  " Copy indent from current line when starting a new line
set smartindent                 " Automatically follow the indentations
set smarttab                    " Insert blanks according the following settings
set softtabstop=4               " Number of spaces that a <Tab> counts for
set tabstop=4                   " Number of spaces that a <Tab> counts for
set shiftwidth=4                " Number of spaces to use for each step of (auto)indent
set expandtab                   " Use the appropriate number of spaces to insert a <Tab>

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

set list
set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»


" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Files
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

syntax on                       " Turn on syntax highlighting
filetype plugin on
filetype indent on


" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Folds
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

set foldmethod=indent           " Fold based on indent
set foldnestmax=3               " Deepest fold is 3 levels
set nofoldenable                " Don't fold by default


" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Turn Off Swap Files
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

set noswapfile
set nobackup
set nowb


" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Code completion
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

set wildmenu                    " Enable ctrl-n and ctrl-p to scroll thru matches
set wildmode=list:longest       " Wildmode type
set wildignore=*.o,*.obj,*~     " Stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=bower_components/**
set wildignore+=node_modules/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif


" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Persistent undo history across sessions
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif


" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Scrolling
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

set scrolloff=8                 " Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1


" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Search
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

set incsearch                   " Find the next match as we type the search
set hlsearch                    " Highlight searches by default
set ignorecase                  " Ignore case when searching
set smartcase                   " When type capital use it


" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Status line
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

set laststatus=2                " Status line configurations

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0 ? '  '.l:branchname.'' : ''
endfunction

set statusline=
set statusline+=%#Pmenu#
set statusline+=%{StatuslineGit()}
set statusline+=\ %#PmenuSbar#
set statusline+=\ %f
set statusline+=\ %=
set statusline+=%#CursorColumn#
set statusline+=\ %Y
set statusline+=\ \|\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ \|\ %{&fileformat}
set statusline+=\ \|\ %p%%
set statusline+=\ \|\ %l:%c
set statusline+=\ \|


" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Enable mouse
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

if has('mouse')
    set mouse=a
endif


" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Navigate between views
"  CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
