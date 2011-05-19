"=============================================================================
" fuzzyfinder_textmate_extend.vim: Extend for FuzzyFinder and
"                                             FuzzyFinderTextMate
"=============================================================================

"=============================================================================
" FUNCTIONS: {{{1

function! Set_Path_Then_Find(paths)
    if exists('g:my_project_root')
        call Clear_Fuzzy_Root()
        ruby << RUBY
          paths = VIM.evaluate("a:paths").split(/\s*,\s*/)
          paths << "" if paths.empty?
          paths.each do |path|
            root = File.join(VIM.evaluate("g:my_project_root"), path)
            VIM.evaluate("Set_Fuzzy_Root('#{root}', 0)")
          end
RUBY
        FuzzyFinderTextMate
    else
        echohl ErrorMsg | echo "The variable g:my_project_root does not exist" | echohl None
    endif
endfunction

" overwrite: 0  => append the a:root at the tail of g:fuzzy_roots
"            1  => replace g:fuzzy_roots with a:root
function! Set_Fuzzy_Root(root, overwrite)
    if a:overwrite == 0
        if exists('g:fuzzy_roots')
            let g:fuzzy_roots += [a:root]
        else
            let g:fuzzy_roots = [a:root]
        endif
    elseif a:overwrite == 1
        let g:fuzzy_roots = [a:root]
    endif
    " source file ~/.vim/plugin/fuzzyfinder_textmate_patch.vim to generate a new instance of FuzzyFileFinder
    source ~/.vim/plugin/fuzzyfinder_textmate_patch.vim
    " echo g:fuzzy_roots
endfunction

function! Clear_Fuzzy_Root()
    unlet! g:fuzzy_roots
endfunction

" }}}1
"=============================================================================
" GLOBAL OPTIONS: {{{1

" ********************* Configuration options of FuzzyFinderTextMate *********************
" Specifies roots in which the FuzzyFinder will search.
" let g:fuzzy_roots = ['~/workspace/BVI/']
" Specifies the maximum number of files that FuzzyFinder allows to be searched
let g:fuzzy_ceiling = 10000
" A delimited list of file glob patterns to ignore. Entries may be delimited with either commas or semi-colons.
let g:fuzzy_ignore = "*~,*.output,*.log,*.xml,*.csv"
" The maximum number of matches to return at a time. Defaults to 200
let g:fuzzy_enumerating_limit = 20
" ********************* Configuration options of FuzzyFinderTextMate *********************

" }}}1
"=============================================================================
" MAPPINGS: {{{1

" Mapping for FuzzyFinder
nnoremap <silent> <A-F> :FuzzyFinderFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
" Mapping for FuzzyFinderTextMate
map <A-f>a :FindAll<CR>
map <A-f>c :FindControllers<CR>
map <A-f>m :FindModels<CR>
map <A-f>v :FindViews<CR>
map <A-f>h :FindHelpers<CR>
map <A-f>s :FindSpecs<CR>
map <A-f>p :FindPublic<CR>
map <A-f>r :FindRails<CR>

" }}}1
"=============================================================================
" COMMANDS: {{{1

command! FindAll call Set_Path_Then_Find("")
command! FindControllers call Set_Path_Then_Find("app/controllers/")
command! FindModels call Set_Path_Then_Find("app/models/")
command! FindViews call Set_Path_Then_Find("app/views/")
command! FindHelpers call Set_Path_Then_Find("app/helpers/")
command! FindSpecs call Set_Path_Then_Find("spec/")
command! FindPublic call Set_Path_Then_Find("public/javascripts/, public/stylesheets/")
command! FindRails call Set_Path_Then_Find("vendor/")

" Set g:fuzzy_roots
command! -nargs=1 SetFuzzyRoot call Set_Fuzzy_Root('<args>', 1)
" Add g:fuzzy_roots
command! -nargs=1 AddFuzzyRoot call Set_Fuzzy_Root('<args>', 0)

" }}}1
"=============================================================================
" vim: set fdm=marker:
