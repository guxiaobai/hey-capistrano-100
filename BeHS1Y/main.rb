gem_group :development do
  gem 'capistrano-rails', '~> 1.7'
  gem 'capistrano-rbenv', '~> 2.2'
end

run_bundle

run "bundle exec cap install"


domain  = ask('domain: ')
user    = ask('user: ')
repo    = ask('repository: ')

# Capistrano
uncomment_lines 'config/deploy.rb', /ask\s+:branch/
uncomment_lines 'config/deploy.rb', /append\s:linked_dirs/

gsub_file 'config/deploy.rb', /(set\s+:application,).*/, "\\1 '#{app_name}'"
gsub_file 'config/deploy.rb', /(set\s+:repo_url,).*/, "\\1 '#{repo}'"
gsub_file 'config/deploy.rb', /(#\s+)(set\s+:deploy_to,).*/, '\2 "/var/www/#{fetch(:application)}"'


# Capistrano::Rbenv
uncomment_lines 'Capfile', /require.*rbenv/
append :linked_files, ".rbenv-vars"

append_to_file 'config/deploy.rb' do
  <<-EOS.strip_heredoc

  # rbenv
  set :rbenv_type, :user
  set :rbenv_ruby, '3.3.8'
  EOS
end

# Capistrano::Bundler
uncomment_lines 'Capfile', /require.*bundle/

append_to_file 'config/deploy.rb' do
  <<-EOS.strip_heredoc

  # bundler
  append :linked_dirs, '.bundle'
  set :bundle_flags, '--verbose'
  # set :bundle_jobs, 8
  # set :bundle_env_variables, {} 
  EOS
end

# Capistrano::Rails
uncomment_lines 'Capfile', /require.*assets/
uncomment_lines 'Capfile', /require.*migrations/




# stage: production
prepend_to_file 'config/deploy/production.rb' do
"server '#{domain}', user: '#{user}', roles: %w{app db web}"
end

git add: "."
git commit: %Q{ -m 'capistrano-rails' }




# Capfile
# require 'capistrano/puma'
# require 'capistrano/puma/nginx'

# require 'capistrano/puma'
# install_plugin Capistrano::Puma
# install_plugin Capistrano::Puma::Nginx
# install_plugin Capistrano::Puma::Systemd

# require "whenever/capistrano"

# require 'capistrano/sidekiq'