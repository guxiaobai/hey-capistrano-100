
gem_group :development do
   gem 'capistrano-rbenv', '~> 2.2'
end

# Capistrano::Rbenv
uncomment_lines 'Capfile', /require.*rbenv/

append_to_file 'config/deploy.rb' do
  <<-EOS.strip_heredoc

  # rbenv
  set :rbenv_type, :user
  set :rbenv_ruby, '3.3.8'
  EOS
end


append :linked_files, ".rbenv-vars"
