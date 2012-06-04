# Add the following line to config/environments/development.rb
# So I can use puts or p to print debug message to log file when I use nginx, which has no way to see STDOUT directly.
STDOUT.reopen(File.open("#{Rails.root}/log/development.log", 'a+'))