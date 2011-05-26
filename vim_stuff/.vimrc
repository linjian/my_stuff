
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Nov 16
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
    set nobackup		" do not keep a backup file, use versions instead
else
    set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif

    augroup END

else

    set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
"command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
"	 	\ | wincmd p | diffthis



" """"""""""""""""""""""""" My Setting """"""""""""""""""""""""
" For Ruby/Rails setting
set nocompatible          " We're running Vim, not Vi!
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

augroup myfiletypes
    " Clear old autocmds in group
    autocmd!
    " autoindent with two spaces, always expand tabs
    autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
augroup END

" No backup
"  set nobackup

" Set gui font
if has("gui_running")
    if has("gui_gtk2")
        "set guifont=Courier\ New\ 14
        set guifont=Monospace\ 14
    elseif has("x11")
        set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
    else
        " set guifont=Courier_New:h11:cDEFAULT
        set guifont=Courier_New:h16
    endif
endif

" Set project-flags
let g:proj_flags="imstg"
" Project-adding-mappings
nmap <silent> <Leader>P :Project<CR>
" Define command for opening maui project
command! Pui Project ~/.vimproject_maui
" Define command for opening adaptor project
command! Padaptor Project ~/.vimproject_adaptor_branches

" Minibufexpl setting
"  let g:miniBufExplMapWindowNavVim = 1
"  let g:miniBufExplMapWindowNavArrows = 1
"  let g:miniBufExplMapCTabSwitchBufs = 1
"  let g:miniBufExplModSelTarget = 1

" ********************* For Mac *********************
" Use option (alt) key as meta key
if has('gui_running') && has('gui_macvim')
    set macmeta
endif

" xargs on Mac doesn't support --null, so change it to -0 instead
if has('mac') || has('macunix') || has('gui_macvim')
    let Grep_Xargs_Options = '-0'
endif
" ********************* For Mac *********************

" Tabbar setting
" Window movement mapping
if has('gui_running')
    map <A-h> <C-W>h
    map <A-j> <C-W>j
    map <A-k> <C-W>k
    map <A-l> <C-W>l
else
    map <C-Left>  <C-W>h
    map <C-Down>  <C-W>j
    map <C-Up>    <C-W>k
    map <C-Right> <C-W>l
endif
" Switch buffers mapping for terminal
if !has('gui_running')
    map <Leader>1 <C-[>1
    map <Leader>2 <C-[>2
    map <Leader>3 <C-[>3
    map <Leader>4 <C-[>4
    map <Leader>5 <C-[>5
    map <Leader>6 <C-[>6
    map <Leader>7 <C-[>7
    map <Leader>8 <C-[>8
    map <Leader>9 <C-[>9
    map <Leader>0 <C-[>0
endif
" Setting this to 0 will mean the window gets as big as
" needed to fit all your buffers."
" let g:Tb_MaxSize = 0
" Update Explorer without navigating
" map <silent> <F5> :TbAup<CR>

" Set commenter
let NERDSpaceDelims = 1
nmap <A-m> <Leader>c<Space>
vmap <A-m> <Leader>c<Space>gv
imap <A-m> <Esc><Leader>c<Space>

" Toggle comment for eruby
function! ErubyCommentToggle() range
    let currentLine = a:firstline
    let theLine = getline(currentLine)
    if stridx(theLine, '<%#') != -1
        let theLine = substitute(theLine, '<%#', '<%', '')
    else
        let theLine = substitute(theLine, '<%', '<%#', '')
    endif
    call setline(currentLine, theLine)
endfunction
nmap <silent> <A-M> :call ErubyCommentToggle()<CR>

" Display the extra tab and whitespace
set list
set listchars=tab:>-,trail:-

" Set cursor motion for insert mode
set winaltkeys=no
imap <A-h> <Left>
imap <A-j> <Down>
imap <A-k> <Up>
imap <A-l> <Right>
imap <A-$> <Esc>A
imap <A-^> <Esc>I
imap <A-d> <Esc>ddi

" Quick save
nmap <A-s> :update<CR>
nmap <C-s> :update<CR>
imap <A-s> <Esc>:update<CR>a
imap <C-s> <Esc>:update<CR>a

" Set to auto read when a file is changed from the outside
set autoread

" ********************* For Linux *********************
" Fast reloading of the .vimrc
map <silent> <Leader>s :source ~/.vimrc<cr>
" Fast editing of .vimrc
map <silent> <Leader>e :e ~/.vimrc<cr>
" ********************* For Linux *********************

" ********************* For windows *******************
" Fast reloading of the .vimrc
" map <silent> <Leader>s :source $VIM/_vimrc<cr>
" Fast editing of .vimrc
" map <silent> <Leader>e :e $VIM/_vimrc<cr>
" ********************* For windows *******************

" Highlight current
if has("gui_running")
    set cursorline
    "hi cursorline guibg=#333333
    "hi CursorColumn guibg=#333333
endif

" Turn on Wild menu
set wildmenu

" Bracket auto complete
imap ( ()<Esc>i
imap ) <C-r>=ClosePair(')')<CR>
imap { {}<Esc>i
imap } <C-r>=ClosePair('}')<CR>
imap [ []<Esc>i
imap ] <C-r>=ClosePair(']')<CR>
imap < <><Esc>i
imap > <C-r>=ClosePair('>')<CR>
imap " <C-r>=CloseQuote('"')<CR>
imap ' <C-r>=CloseQuote("'")<CR>

function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

function! CloseQuote(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char . a:char . "\<left>"
    endif
endfunction

" Increase and decrease the size of a window
map <A--> <C-w>-
map <A-=> <C-w>+

" Jump to change Mapping
map <A-]> ]c
map <A-[> [c

" Define command for VCSVimDiff
command! Vd VCSVimDiff

" Copy and paste with clipboard
" current selection
map <C-c> "*y
map <C-v> "*p
" real clipboard
map <C-C> "+y
map <C-V> "+p

" Point to the file which be generated by ctags
set tags=tags;
" set autochdir

" Move a line up or down
map <silent> <A-Down> :m+<CR>
map <silent> <A-Up> :m-2<CR>
" Move a block up or down
vmap <silent> <A-Down> :m'>+<CR>`<my`>mzgv`yo`z
vmap <silent> <A-Up> :m'<-2<CR>`>my`<mzgv`yo`z

" Disable GUI menu and toolbar
if has("gui_running")
  set guioptions-=m
  set guioptions-=T
endif

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
if has("unix")
    map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
else
    map ,e :e <C-R>=expand("%:p:h") . "\" <CR>
endif

" Close TabBar, Close Project, and then quit from Vim
" Thus Vim can save session correctly before quit
" map <silent> <A-z> :TbStop<CR><C-W>hZZ:q<CR>
map <silent> <A-z> :NERDTreeClose<CR>:qa<CR>


" Jump to the next/previous in quickfix list
map <silent> <A-n> :cnext<CR>
map <silent> <A-p> :cprevious<CR>

" The 'Grep_Skip_Dirs' variable specifies the list of directories to skip
" while doing recursive searches. By default, this is set to 'RCS CVS SCCS'.
" Configurate it for grep.vim
let Grep_Skip_Dirs = '.svn log'

" For setting foldmethod
map <silent> <Leader>f :set foldmethod=syntax<CR>
map <silent> <Leader>F :set foldmethod=manual<CR>

" count of backups to hold - purge older once.
let g:backup_purge=200

" Act as <F12> toggle project tree
nmap <silent> <F12> :NERDTreeToggle<CR>

" Toggle tabbar
" nmap <silent> <F4> :TbToggle<CR>

" Set default project root path
if !has("g:my_project_root")
    let g:my_project_root = '.'
endif

" Always display the status line
set laststatus=2

" Sort by the buffer's name -- bufexplorer
let g:bufExplorerSortBy='name'

" Cursor one line at a time when :set wrap
nnoremap <Down> gj
nnoremap <Up> gk

" set encoding for chinese
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
" set fileformats=unix
" set encoding=prc

" Make all windows (almost) equally high and wide
nnoremap w= <C-w>=

" Fix 'No newline at end of file' issue
set noendofline
set binary