SOURCE_DIR = '~/mystuff'

VIM_STUFF_DIR = 'vim_stuff'
CONFIG_FILES_DIR = 'config_files'

cmd = "ln -s #{SOURCE_DIR}/#{VIM_STUFF_DIR}/.vim ~/.vim"
`#{cmd}`
puts cmd

cmd = "ln -s #{SOURCE_DIR}/#{VIM_STUFF_DIR}/.vimrc ~/.vimrc"
`#{cmd}`
puts cmd

puts ""
puts "add the following line to ~/.bashrc or ~/.profile"
puts "source #{SOURCE_DIR}/#{CONFIG_FILES_DIR}/.bashrc"

puts ""
cmd = "ln -s #{SOURCE_DIR}/#{CONFIG_FILES_DIR}/.git-completion.bash ~/.git-completion.bash"
`#{cmd}`
puts cmd

cmd = "ln -s #{SOURCE_DIR}/#{CONFIG_FILES_DIR}/.gitconfig ~/.gitconfig"
`#{cmd}`
puts cmd

cmd = "ln -s #{SOURCE_DIR}/#{CONFIG_FILES_DIR}/.gitignore ~/.gitignore"
`#{cmd}`
puts cmd

cmd = "ln -s #{SOURCE_DIR}/#{CONFIG_FILES_DIR}/.irbrc ~/.irbrc"
`#{cmd}`
puts cmd

cmd = "ln -s #{SOURCE_DIR}/vimwiki ~/vimwiki"
`#{cmd}`
puts cmd

# ln -s ~/mystuff/code/deferred_garbage_collection_all_in_one.rb /Users/apple/workspace/repository/dpu/spec/support/deferred_garbage_collection_all_in_one.rb
# ln -s ~/mystuff/code/deferred_garbage_collection_all_in_one.rb /Users/apple/workspace/repository/dpu/features/step_definitions/deferred_garbage_collection_all_in_one.rb
