"=============================================================================
" grep_extend.vim: Extend for grep.vim
"=============================================================================

"=============================================================================
" FUNCTIONS: {{{1

function! Set_And_Search(file_pattern, path, visual_mode)
    if a:path != ""
        let g:Grep_Start_Dir=getcwd().a:path
    endif

    let pattern = ""
    if a:visual_mode == "true"
        let pattern = @p
    else
        let pattern = expand("<cword>")
    endif
    " echo pattern

    execute "Rgrep ".pattern." ".a:file_pattern
endfunction

" }}}1
"=============================================================================
"=============================================================================
" MAPPINGS: {{{1

nmap <M-g>a :SearchAll<CR>
nmap <M-g>r :SearchRuby<CR>
nmap <M-g>h :SearchView<CR>
nmap <M-g>j :SearchJs<CR>
nmap <M-g>c :SearchCss<CR>

vmap <M-g>a "py:SearchAllVisual<CR>
vmap <M-g>r "py:SearchRubyVisual<CR>
vmap <M-g>h "py:SearchViewVisual<CR>
vmap <M-g>j "py:SearchJsVisual<CR>
vmap <M-g>c "py:SearchCssVisual<CR>

" }}}1
"=============================================================================
"=============================================================================
" COMMANDS: {{{1

command! SearchAll call Set_And_Search("*", "", "false")
command! SearchRuby call Set_And_Search("*.rb", "", "false")
command! SearchView call Set_And_Search("*.haml *.html", "/app/views/", "false")
command! SearchJs call Set_And_Search("*.js", "/public/javascripts/", "false")
command! SearchCss call Set_And_Search("*.sass *.css", "/public/stylesheets/", "false")

command! SearchAllVisual call Set_And_Search("*", "", "true")
command! SearchRubyVisual call Set_And_Search("*.rb", "", "true")
command! SearchViewVisual call Set_And_Search("*.haml *.html", "/app/views/", "true")
command! SearchJsVisual call Set_And_Search("*.js", "/public/javascripts/", "true")
command! SearchCssVisual call Set_And_Search("*.sass *.css", "/public/stylesheets/", "true")

" }}}1
"=============================================================================
" vim: set foldmethod=marker:
