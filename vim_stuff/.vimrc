" From sample vimrc file {{{1
"=============================================================================
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" keep a backup file
set backup

set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching

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

    set autoindent              " always set autoindenting on

endif " has("autocmd")
" }}}1

" My Setting {{{1
"=============================================================================
" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

augroup myfiletypes
    " Clear old autocmds in group
    autocmd!
    " autoindent with two spaces, always expand tabs
    autocmd FileType ruby,eruby,yaml set autoindent shiftwidth=2 softtabstop=2 expandtab tabstop=2
augroup END

" Set gui font
if has("gui_running")
    if has("gui_gtk2")
        "set guifont=Courier\ New\ 14
        set guifont=Monospace\ 12
    elseif has("x11")
        set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
    else
        " set guifont=Courier_New:h11:cDEFAULT
        set guifont=Courier_New:h16
    endif
endif

" ********************* For Mac *********************
" Use option (alt) key as meta key
if has('gui_running') && has('gui_macvim')
    set macmeta
    " since I mapped <M-Down> in .vimrc and I found that <M-Down> mapping has been override somewhere in GUI mode.
    " I execute command ":verbose map <M-Down>" to see where it was last defined, and it turns out in
    " /Applications/MacVim.app/Contents/Resources/vim/gvimrc
    " So I add following line to disable the "HIG Cmd and Option movement mappings"
    let macvim_skip_cmd_opt_movement = 1
endif

" xargs on Mac doesn't support --null, so change it to -0 instead
if has('mac') || has('macunix') || has('gui_macvim')
    let Grep_Xargs_Options = '-0'
endif
" ********************* For Mac *********************

" Window movement mapping
map <M-h> <C-W>h
map <M-j> <C-W>j
map <M-k> <C-W>k
map <M-l> <C-W>l
map <C-Left>  <C-W>h
map <C-Down>  <C-W>j
map <C-Up>    <C-W>k
map <C-Right> <C-W>l

" Set commenter
let NERDSpaceDelims = 1
nmap <M-m> <Leader>c<Space>
vmap <M-m> <Leader>c<Space>gv
imap <M-m> <Esc><Leader>c<Space>

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
nmap <silent> <M-M> :call ErubyCommentToggle()<CR>

" Display the extra tab and whitespace
set list
set listchars=tab:>-,trail:-

" Set cursor motion for insert mode
set winaltkeys=no
imap <M-h> <Left>
imap <M-j> <Down>
imap <M-k> <Up>
imap <M-l> <Right>
imap <M-$> <Esc>A
imap <M-^> <Esc>I
imap <M-d> <Esc>ddi

" Quick save
nmap <M-s> :update<CR>
nmap <C-s> :update<CR>
imap <M-s> <Esc>:update<CR>a
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
set cursorline

" Turn on Wild menu
set wildmenu

" Increase and decrease current window height by 1
map <M--> <C-w>-
map <M-=> <C-w>+

" Increase and decrease current window width by 1
nnoremap <M-,> <C-w><
nnoremap <M-.> <C-w>>

" Make all windows (almost) equally high and wide
nnoremap w= <C-w>=

" Set current window highest possible
nnoremap w<Up> <C-w>_
" Set current window height to 1
nnoremap w<Down> 1<C-w>_

" Set current window widest possible
nnoremap w<Left> :vertical-resize<CR>
" Set current window width to 1
nnoremap w<Right> :vertical-resize 1<CR>

" Don't make all windows to be the same size after splitting or closing a window
set noequalalways

" Jump to change Mapping
map <M-]> ]c
map <M-[> [c

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
map <silent> <M-Down> :m+<CR>
map <silent> <M-Up> :m-2<CR>
" Move a block up or down
vmap <silent> <M-Down> :m'>+<CR>`<my`>mzgv`yo`z
vmap <silent> <M-Up> :m'<-2<CR>`>my`<mzgv`yo`z

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

" Jump to the next/previous in quickfix list
map <silent> <M-n> :cnext<CR>
map <silent> <M-p> :cprevious<CR>

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

" Set default project root path
if !has("g:my_project_root")
    let g:my_project_root = '.'
endif

" Always display the status line
set laststatus=2

" Cursor one line at a time when :set wrap
nnoremap <Down> gj
nnoremap <Up> gk

" set encoding for chinese
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
" set fileformats=unix
" set encoding=prc

" Fix 'No newline at end of file' issue
set noendofline
set binary

" switch number(2/4) of spaces that a <Tab> counts for
map <silent> <M-t>2 :set tabstop=2<CR>
map <silent> <M-t>4 :set tabstop=4<CR>

" fix meta-keys in terminal
if !has('gui_running')
    " fix meta-keys which generate <Esc>a .. <Esc>z
    let c='a'
    while c <= 'z'
      " exec "set <M-".toupper(c).">=\e".c
      " exec "set <M-".tolower(c).">=\e".c
      " exec "map \e".toupper(c)." <M-".toupper(c).">"
      exec "map \e".tolower(c)." <M-".tolower(c).">"
      exec "imap \e".tolower(c)." <M-".tolower(c).">"
      let c = nr2char(1+char2nr(c))
    endw

    for c in ["-", "=", ",", "."]
        exec "map \e".c." <M-".c.">"
    endfor
    map <Up> <M-Up>
    map <Down> <M-Down>

    set timeoutlen=100
endif

" For taglist.vim {{{2
" Toggle the taglist window
nnoremap <silent> <F8> :TlistToggle<CR>

" Specify the path of exuberant ctags
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'

" Move the cursor to the taglist window as opening it
let Tlist_GainFocus_On_ToggleOpen = 1

" Display the tags for only the current window
let Tlist_Show_One_File = 1

" Automatically close the fold for the inactive files/buffers and open only for the current buffer in the taglist window
let Tlist_File_Fold_Auto_Close = 1

" Reduce the number of empty lines in the taglist window
let Tlist_Compact_Format = 1

" Not display the scope of the tags next to the tag names
let Tlist_Display_Tag_Scope = 0
" }}}2

" Enable modeline option so a number of lines at the beginning and end of the file are checked for modelines.
set modeline

" Unfold by default
set foldlevel=99

" Define characters to auto close
" Refer to http://www.vim.org/scripts/script.php?script_id=2009
"   cause there are more than one autoclose.vim plugins
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '<': '>'}

" Expand existing tabs in visual mode
vmap <Tab> :retab<CR>
" }}}1

"=============================================================================
" vim: set foldmethod=marker: