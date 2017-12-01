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

" To use vim plugins for Go {{{1
" filetype off
" filetype plugin indent off
" set runtimepath+=$GOROOT/misc/vim
" filetype plugin indent on
" syntax on

" To gofmt Go source files when they are saved.
" autocmd FileType go autocmd BufWritePre <buffer> Fmt

" To always enable the compiler plugin in Go source files
" autocmd FileType go compiler go
" }}}1

" My Setting {{{1
"=============================================================================
" Assign global variables by env {{{2
if (has("win32") || has("win64") || has("win32unix"))
    let g:isWin = 1
    let g:isUnix = 0
elseif has('unix')
    let g:isUnix = 1
    let g:isWin = 0
endif

if (has("mac") || has("macunix"))
    let g:isMac = 1
else
    let g:isMac = 0
endif

if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif
" }}}2

" Set tab key spaces {{{2
augroup myfiletypes
    " Clear old autocmds in group
    autocmd!
    " autoindent with two spaces, always expand tabs
    autocmd FileType ruby,eruby,yaml set autoindent tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup END
" }}}2

" Set GUI font {{{2
if (g:isGUI)
    if has("gui_gtk2")
        "set guifont=Courier\ New\ 14
        set guifont=Monospace\ 11
    elseif has("x11")
        set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
    elseif (g:isMac)
        " set guifont=Monaco:h15
        set guifont=Menlo:h14
    else
        " set guifont=Courier_New:h11:cDEFAULT
        set guifont=Courier_New:h16
    endif
endif
" }}}2

" Set for Mac {{{2
" Use option (alt) key as meta key
if (g:isMac && g:isGUI)
    set macmeta
    " since I mapped <M-Down> in .vimrc and I found that <M-Down> mapping has been override somewhere in GUI mode.
    " I execute command ":verbose map <M-Down>" to see where it was last defined, and it turns out in
    " /Applications/MacVim.app/Contents/Resources/vim/gvimrc
    " So I add following line to disable the "HIG Cmd and Option movement mappings"
    let macvim_skip_cmd_opt_movement = 1
endif

" xargs on Mac doesn't support --null, so change it to -0 instead
if (g:isMac)
    let Grep_Xargs_Options = '-0'
endif
" }}}2

" Fix meta-keys in terminal {{{2
if (!g:isGUI)
    " fix meta-keys which generate <Esc>a .. <Esc>z
    let c='a'
    while c <= 'z'
      " execute "set <M-".toupper(c).">=\e".c
      " execute "set <M-".tolower(c).">=\e".c
      " execute "map \e".toupper(c)." <M-".toupper(c).">"
      execute "map \e".tolower(c)." <M-".tolower(c).">"
      execute "imap \e".tolower(c)." <M-".tolower(c).">"
      let c = nr2char(1+char2nr(c))
    endw

    for i in range(0,9)
        execute "map \e".i." <M-".i.">"
    endfor

    for c in ["-", "=", ",", "."]
        execute "map \e".c." <M-".c.">"
    endfor
    map <Up> <M-Up>
    map <Down> <M-Down>

    set timeoutlen=100
endif
" }}}2

" Plugin mapping and setting {{{2
" Set for NERD_commenter.vim {{{3
let NERDSpaceDelims = 1
nmap <M-m> <Leader>c<Space>
vmap <M-m> <Leader>c<Space>gv
imap <M-m> <Esc><Leader>c<Space>
" }}}3

" Set for taglist.vim {{{3
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
" }}}3

" Set for Vim Chinese Doc {{{3
" The cn docs are installed here by default
set runtimepath+=/usr/share/vim/vimfiles
" Use en help first
set helplang=en,cn
" }}}3

" Set for grep.vim {{{3
" The 'Grep_Skip_Dirs' variable specifies the list of directories to skip
" while doing recursive searches. By default, this is set to 'RCS CVS SCCS'.
let Grep_Skip_Dirs = '.svn .git log .backups tmp images'

" Mapping for normal mode
nmap <M-g>a :execute "let g:Grep_Start_Dir=getcwd() \| Rgrep <cword> *"<CR>
nmap <M-g>r :execute "let g:Grep_Start_Dir=getcwd() \| Rgrep <cword> *.rb"<CR>
nmap <M-g>h :execute "let g:Grep_Start_Dir=getcwd().'/app/views/' \| Rgrep <cword> *.haml *.html"<CR>
nmap <M-g>j :execute "let g:Grep_Start_Dir=getcwd().'/public/javascripts/' \| Rgrep <cword> *.js"<CR>
nmap <M-g>c :execute "let g:Grep_Start_Dir=getcwd().'/public/stylesheets/' \| Rgrep <cword> *.sass *.css"<CR>

" Mapping for visual mode
vmap <M-g>a "gy:execute "let g:Grep_Start_Dir=getcwd() \| Rgrep <C-R>g *"<CR>
vmap <M-g>r "gy:execute "let g:Grep_Start_Dir=getcwd() \| Rgrep <C-R>g *.rb"<CR>
vmap <M-g>h "gy:execute "let g:Grep_Start_Dir=getcwd().'/app/views/' \| Rgrep <C-R>g *.haml *.html"<CR>
vmap <M-g>j "gy:execute "let g:Grep_Start_Dir=getcwd().'/public/javascripts/' \| Rgrep <C-R>g *.js"<CR>
vmap <M-g>c "gy:execute "let g:Grep_Start_Dir=getcwd().'/public/stylesheets/' \| Rgrep <C-R>g *.sass *.css"<CR>
" }}}3

" Set for rails.vim {{{3
nmap <M-r>a  :A<CR>
nmap <M-r>ae :AE<CR>
nmap <M-r>as :AS<CR>
nmap <M-r>av :AV<CR>

nmap <M-r>r  :R<CR>
nmap <M-r>re :RE<CR>
nmap <M-r>rs :RS<CR>
nmap <M-r>rv :RV<CR>
" }}}3

" Set for rspec.vim {{{3
if (g:isMac && g:isGUI)
    " run with zeus
    " let g:rspec_command = "silent !~/.vim/bin/run_in_iterm 'zeus rspec {spec}'"
    let g:rspec_command = "silent !~/.vim/bin/run_in_iterm 'rspec {spec}'"
else
    " let g:rspec_command = "!echo zeus rspec {spec} && zeus rspec {spec}"
    let g:rspec_command = "!echo rspec {spec} && rspec {spec}"
endif

map <leader>d :call RunNearestSpec()<CR>
map <leader>l :call RunLastSpec()<CR>
map <leader>t :call RunCurrentSpecFile()<CR>
" }}}3

" Mapping for ack.vim
nmap <M-a> :execute "tabnew \| Ack ".expand("<cword>")<CR>
vmap <M-a> "ay:execute "tabnew \| Ack <C-R>a"<CR>

" Set for backup.vim
" http://www.vim.org/scripts/script.php?script_id=1537
" NOTE: This plugin has been hacked by myself
" Count of backups to hold - purge older once.
let g:backup_purge=200

" Set for LoadProjects.vim
" Set default project root path
if !has("g:my_project_root")
    let g:my_project_root = '.'
endif

" Set for autoclose.vim
" Define characters to auto close
" Refer to http://www.vim.org/scripts/script.php?script_id=2009
"   cause there are more than one autoclose.vim plugins
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '<': '>'}

" Map for NERD_tree.vim
nmap <silent> <F12> :NERDTreeToggle<CR>

" Set for godef.vim
" Open the definition in a new tab.
let g:godef_split=2

" Jumps to the same file to move cursor instead of splitting
let g:godef_same_file_in_same_window=1

" The original 'gd' mapping is hard to press, 'gf' is easier and compatible with rails.vim
autocmd FileType go nnoremap <buffer> gf :call GodefUnderCursor()<cr>
" }}}2

" Custom mapping {{{2
" Window movement mapping {{{3
map <M-h> <C-W>h
map <M-j> <C-W>j
map <M-k> <C-W>k
map <M-l> <C-W>l
map <C-Left>  <C-W>h
map <C-Down>  <C-W>j
map <C-Up>    <C-W>k
map <C-Right> <C-W>l
" }}}3

" Window resize {{{3
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
" }}}3

" Set cursor motion for insert mode {{{3
imap <M-h> <Left>
imap <M-j> <Down>
imap <M-k> <Up>
imap <M-l> <Right>
imap <M-$> <Esc>A
imap <M-^> <Esc>I
imap <M-d> <Esc>ddi
" }}}3

" Tab page setting {{{3
" Switch tab page by number
for i in range(1,9)
    execute "map <M-".i."> ".i."gt"
endfor
map <M-0> :tablast<CR>

" Go to next/previous tab page
map <C-Tab> gt
map <C-S-Tab> gT

" Move tab page to next/previous
map <silent> th :execute "tabmove -1"<CR>
map <silent> tl :execute "tabmove +1"<CR>
" map <silent> th :execute "tabmove ".(tabpagenr()-2)<CR>
" map <silent> tl :execute "tabmove ".tabpagenr()<CR>

" Describe the text to use in a label of the GUI tab page
" 1:filename +
set guitablabel=%N:%t\ %M%#HLTabLineSel#

" Open new tab
map <M-T> :execute "tabnew"<CR>
" Open current file in a new tab
map <silent> tn :execute "tabnew %"<CR>
" }}}3

" Quick save {{{3
nmap <M-s> :update<CR>
nmap <C-s> :update<CR>
imap <M-s> <Esc>:update<CR>a
imap <C-s> <Esc>:update<CR>a
" }}}3

" Copy and paste with clipboard {{{3
map <C-c> "+y
map <C-v> "+p

" Paste in command mode
cmap <C-V> <C-r>+
" }}}3

" Substitute all text that current visual area matched with last yank content
vmap <C-p> "py:%s/<C-R>p/<C-R>0/gc<CR>
" Substitute all text that last search pattern matched with last yank content
nmap <C-p> :%s/<C-R>//<C-R>0/gc<CR>

" Fast reloading of the .vimrc
map <silent> <Leader>s :source $MYVIMRC<CR>
" Fast editing of .vimrc
map <silent> <Leader>e :e $MYVIMRC<CR>

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
if (g:isUnix)
    map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
else
    map ,e :e <C-R>=expand("%:p:h") . "\" <CR>
endif

" Jump to change Mapping
map <M-]> ]c
map <M-[> [c

" Jump to the next/previous in quickfix list
map <silent> <M-n> :cnext<CR>
map <silent> <M-p> :cprevious<CR>

" Move a line up or down
map <silent> <M-Down> :m+<CR>
map <silent> <M-Up> :m-2<CR>
" Move a block up or down
vmap <silent> <M-Down> :m'>+<CR>`<my`>mzgv`yo`z
vmap <silent> <M-Up> :m'<-2<CR>`>my`<mzgv`yo`z

" Cursor one line at a time when :set wrap
nnoremap <Down> gj
nnoremap <Up> gk

" For setting foldmethod
map <silent> <Leader>f :set foldmethod=syntax<CR>
map <silent> <Leader>F :set foldmethod=manual<CR>

" switch number(2/4) of spaces that a <Tab> counts for
map <silent> <M-t>2 :set tabstop=2<CR>
map <silent> <M-t>4 :set tabstop=4<CR>

" Expand existing tabs in visual mode
vmap <Tab> :retab<CR>

" To command mode directly
" noremap ; <S-:>
" vmap ; ;
" }}}2

" Other mapping {{{2
" Toggle comment for eruby {{{3
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
" }}}3
" }}}2

" Other setting {{{2
" using ruby interface
set rubydll=~/.rvm/rubies/default/lib/libruby.dylib
" Display the extra tab and whitespace
set list
set listchars=tab:>-,trail:-

" Don't use ALT keys for menus.  ALT key combinations can be mapped
set winaltkeys=no

" Set to auto read when a file is changed from the outside
set autoread

" Highlight current
set cursorline

" Turn on Wild menu
set wildmenu

" Don't make all windows to be the same size after splitting or closing a window
set noequalalways

" Point to the file which be generated by ctags
set tags=tags;

" Disable GUI menu and toolbar
if (g:isGUI)
  set guioptions-=m
  set guioptions-=T
endif

" Always display the status line
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Set encoding for chinese
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
" set fileformats=unix
" set encoding=prc

" Fix 'No newline at end of file' issue
set noendofline
set binary

" Enable modeline option so a number of lines at the beginning and end of the file are checked for modelines.
set modeline

" Unfold by default
set foldlevel=99

" Use another color scheme while diff
if &diff
    colorscheme peaksea
endif
au FilterWritePre * if &diff | colorscheme peaksea | endif
au BufWinLeave * if &diff | colorscheme vividchalk | endif
" }}}2
" }}}1

"=============================================================================
" vim: set foldmethod=marker: