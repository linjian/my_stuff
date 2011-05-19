"=============================================================================
" LoadProjects.vim: Define commands for loading projects
"=============================================================================

"=============================================================================
" COMMANDS: {{{1

" for office machine {{{2
command! LoadDpu call s:load_project('dpu')

" command! LoadRpm call s:load_project('Rpm')
" command! LoadMaui call s:load_project('Maui')
" command! LoadBvi call s:load_project('Bvi')
" command! LoadBvi22 call s:load_project('bvi_2.2')
" }}}2

" for home machine {{{2
" command! LoadDaemons1010 call s:load_project('daemons-1.0.10')
" }}}2

" }}}1
"=============================================================================
" FUNCTIONS: {{{1

" Set value of g:my_project_root, load session, open project, etc
function! s:load_project(project_name)
    call s:set_for_code_folding()
    call s:set_my_project_root(a:project_name)
    call s:open_session(a:project_name)
    " call s:open_project(a:project_name)
    call s:open_project_with_nerdtree(a:project_name)
endfunction

function! s:set_my_project_root(project_name)
    " let g:my_project_root = '~/workspace/' . a:project_name . '/'
    let g:my_project_root = '~/workspace/repository/' . a:project_name . '/'
endfunction

function! s:open_session(project_name)
    execute "SessionOpen " . a:project_name
    " Save and hide the tabbar
    execute "normal \<C-W>t"
    execute "update"
    " execute "TbStop"
endfunction

function! s:set_for_code_folding()
    set foldmethod=syntax
    set foldlevel=99
endfunction

function! s:open_project(project_name)
    execute "Project ~/.vimproject_" . a:project_name
    " Cause we've set foldlevel=99, all folds will be unfolded when open project
    " window. So using zM to close all folds.
    execute "normal zM"
    " Move the cursor to the main window(right and bottom)
    execute "normal \3<C-W>l\<C-W>b"
endfunction

function! s:open_project_with_nerdtree(project_name)
    " execute "NERDTree ~/workspace/" . a:project_name
    execute "NERDTree ~/workspace/repository/" . a:project_name
    " Move the cursor to the main window(right and bottom)
    execute "normal \3<C-W>l\<C-W>b"
    " Hide the NERD tree
    execute "NERDTreeToggle"
endfunction

" }}}1
"=============================================================================
" vim: set fdm=marker:
