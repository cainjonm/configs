" _vimrc
" stolen a lot from someone online (eek)

"setup pathogen
"call pathogen#infect()

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'sjl/gundo.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'jcrocholl/pep8'
Bundle 'derekwyatt/vim-fswitch'
Bundle 'tpope/vim-git'
Bundle 'reinh/vim-makegreen'
Bundle 'derekwyatt/vim-protodef'
Bundle 'rson/vim-conque'
Bundle 'Raimondi/delimitMate'
Bundle 'vim-scripts/LaTeX-Box'
Bundle 'vim-scripts/mru.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'fs111/pydoc.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/snipmate-snippets'
Bundle 'vim-scripts/TaskList.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
Bundle 'Twinside/vim-hoogle'
Bundle 'edsono/vim-matchit'
Bundle 'majutsushi/tagbar'
Bundle 'Lokaltog/vim-powerline'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'godlygeek/tabular'

Bundle 'L9'
Bundle 'FuzzyFinder'

filetype plugin indent on

syntax on

"this makes it so you don't get an error when hiding a buffer (that's modified)
set hidden

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10

set encoding=utf-8
let g:Powerline_symbols='fancy'

"set the map leader to ,
let mapleader = ','

"get rid of the bad bad bad up,down,left,right keys (in normal mode)
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
"get rid of bad keys in insert mode
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

"remap j and k to gj and gk
nnoremap j gj
nnoremap k gk

"we don't need no compatibility
set nocompatible

"we want syntax on, filetype recognition on, and filetype plugin indentation on
"no matter what
syntax on
filetype on
filetype plugin indent on

"we want our files to be encoded using utf-8
set encoding=utf-8
set fileencoding=utf-8

"we want to keep backups of our code
set backup
"if we're using windows, have backup in vimfiles folder, otherwise, just in home
if has('win32')
    let s:homedir = "$HOME/vimfiles"
else
    let s:homedir = "$HOME/.vim/"
endif

"set the backup directory now..
execute "set backupdir=" . s:homedir . "/.backups"

"we want our history length to be 5000
set history=5000
set viminfo='1024,<0,s100,f0,r/tmp,r/mnt

"change how we want our appearance

"lets try solarized
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized


"get rid of the gui crap if we have win32 version
if has('win32')
    set guifont=Consolas:h11:w6
    hi StatusLine gui=NONE
    hi User1 gui=NONE
    hi User2 gui=NONE
    hi WildMenu gui=NONE
endif

"remove GUI menu and toolbars
set guioptions-=T
set guioptions-=m

"if we're in gui mode,
"highlight the current line we're on, and highlight the current column
if has('gui_running')
    set cursorline
    set cursorcolumn
endif

"make backspace work like normal
set backspace=indent,eol,start
"show the line and column number of cursor position, separated by comma
set ruler
"show the partial command in the last line of the screen
set showcmd
"display line numbers
set number
"make wordwrap happen
set wrap

" Highlight searches (use <C-L> to temporarily turn off highlighting)
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
set hlsearch
nnoremap <C-L> :nohl<CR><C-L>

"set search related options
"show current matches of a search as the search is being input
set incsearch

"show previous matches using highlighting
set hls

"make sure we don't ignore case
set noignorecase

"when splitting, we want to split to the right
set splitright

"make tabs and so forth sane defaults
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"set smartindentation
set smartindent

"set when we'll have a last status line (always)
set laststatus=2

"set advanced mode command input (so we can use <Tab>
set wildmenu

"Bouncy parens, show where our brackets etc are ending
set showmatch

"we don't want visual bells
set t_vb=''

"make movement better
set nostartofline

" Stolen from someone who stole it from:
" Stolen from http://github.com/ciaranm/dotfiles-ciaranm/tree/master
" just sets the characters to show at eol, tabs, etc etc.
if (&termencoding == "utf-8") || has("gui_running")
    if v:version >= 700
        set list listchars=eol:\ ,tab:»-,trail:·,precedes:…,extends:…,nbsp:‗
    else
        set list listchars=eol:\ ,tab:»·,trail:·,extends:…
    endif
else
    if v:version >= 700
        set list listchars=eol:\ ,tab:>-,trail:.,extends:>,nbsp:_
    else
        set list listchars=eol:\ ,tab:>-,trail:.,extends:>
    endif
endif

"fuction to automatically input the ifndef/define stuff for C/C++
function! Ifndef()
    let str = toupper(expand("%:t:r"))
    execute "norm i#ifndef " . str
    norm o
    execute "norm i#define " . str
    norm o
    norm o
    norm i#endif
endfunction

"S-arrows suck
vnoremap <S-Up> <Up>
inoremap <S-Up> <Up>
nnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>
inoremap <S-Down> <Down>
nnoremap <S-Down> <Down>

"indent fun
vnoremap > >gv
vnoremap < <gv
vnoremap <Tab> >
vnoremap <S-Tab> <

"set directory to current file
    nnoremap <Leader>c :lcd %:h<CR>

"<Leader>bd remove current file from buffer list
nnoremap <Leader>bd :silent bufdo! bd<CR>
nnoremap <Leader>BD :silent bufdo! bd!<CR>

"annoying, remap to no op.
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

function! IsDiff(col)
    let hlID = diff_hlID(".", a:col)
    return hlID==24
endfunction

" Jump to the position in a diff line where the difference starts
function! FindDiffOnLine()
    let c = 1
    while c < col("$")
        if IsDiff(c)
            call cursor(".", c)
            return
        endif
        let c += 1
    endwhile
endfunction

nnoremap <silent> ]c ]c:call FindDiffOnLine()<CR>
nnoremap <silent> [c [c:call FindDiffOnLine()<CR>

"help prevent getting the Hit-enter messages with vim
"set shortmess=a
"if we're using windows, we want our yanks to go into the unnamed register
"so we can copy and paste directly from windows
if has('win32')
    set clipboard=unnamed
endif

"completion settings
set wildmode=longest,list

"set undodir=C:\undo\
set undodir=~/.vim/undo
set undofile

"make clearing highlights easier
nnoremap <Leader><Space> :noh<CR>

"when we lose focus, automatically save
au FocusLost * :wa

"set <Leader>w to make a new vertical split and then jump to it.
nnoremap <leader>w <C-w>v<C-w>l

" jj to exit insert mode
imap jj <Esc>

"create mappings for command_T
"open filelist in current directory with <Leader>o
noremap <Leader>o <Esc>:CommandT<CR>
"re read file list in cur directory
noremap <Leader>O <Esc>:CommandTFlush<CR>
"open currently open buffers
noremap <Leader>m <Esc>:CommandTBuffer<CR>

"create mappings etc for tagbar
let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>

"setup omnicpptags
"set tags+=~/.vims/tags/cpp
"et tags+=~/.vim/tags/gl

"build tags of own projects with Ctrl-F12
"map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"OmniCppComplete
"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"
"let OmniCpp_ShowAccess = 1
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
"let OmniCpp_MayCompleteDot = 1 " autocomplete after .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
"let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
"" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview
"set up SuperTab for omnicompletion
"let g:SuperTabDefaultCompletionType = "context"

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

"mapping for tasklist
map <Leader>td <Plug>TaskList<CR>

"see diffs on past using <Leader>g
map <Leader>g :GundoToggle<CR>

map ~ :Latexmk<CR>
let g:LatexBox_latexmk_options = '-pvc'

nmap <F8> :TagbarToggle<CR>
nmap <Leader>k :Tabularize<CR>
set clipboard=unnamedplus

" lazily done C# crap
set errorformat=\%#%f(%l\\\,%c):\ %m
map <F5>!mdtool build<CR>
