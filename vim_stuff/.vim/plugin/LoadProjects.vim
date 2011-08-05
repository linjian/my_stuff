"=============================================================================
" LoadProjects.vim: Define commands for loading projects
"=============================================================================

"=============================================================================
" COMMANDS: {{{1
command! LoadDpu call s:load_project('~/workspace/repository/dpu/')
" }}}1
"=============================================================================
" FUNCTIONS: {{{1
" Set value of g:my_project_root, change dir, etc
function! s:load_project(project_path)
    " Set my_project_root
    let g:my_project_root = a:project_path
    " Change to current directory
    execute 'cd' . a:project_path
    " Use sessionman.vim
    call s:load_or_create_session(a:project_path)
endfunction

function! s:load_or_create_session(project_path)
    let s:session_name = split(a:project_path, '/')[-1]
    if findfile('~/.vim/sessions/' . s:session_name) == ''
        execute 'SessionSaveAs ' . s:session_name
    else
        execute 'SessionOpen ' . s:session_name
    endif
endfunction
" }}}1
"=============================================================================
" vim: set foldmethod=marker:
