gem_group :development do
  gem 'capistrano-rails', '~> 1.7'
end

run_bundle

run "bundle exec cap install"

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