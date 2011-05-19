" ********************* Copy from fuzzyfinder_textmate.vim *********************
" Don't cache the finder instance, so we can set the value of g:fuzzy_roots dynamicly.
if has("ruby")

ruby << RUBY
  self.class.class_eval do
    # use define_method instead of def to avoid 'TypeError: can't modify frozen string'
    define_method :finder do
      begin
        # Do NOT call method 'split' from Array
        roots = VIM.evaluate("g:fuzzy_roots")
        ceiling = VIM.evaluate("g:fuzzy_ceiling").to_i
        ignore = VIM.evaluate("g:fuzzy_ignore").split(/[;,]/)
        FuzzyFileFinder.new(roots, ceiling, ignore)
      end
    end
  end
RUBY
endif
" ********************* Copy from fuzzyfinder_textmate.vim *********************
