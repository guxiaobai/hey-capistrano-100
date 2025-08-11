gem_group :development do
  gem 'capistrano-rails', '~> 1.7'
  gem 'capistrano-rbenv', '~> 2.2'
  gem 'capistrano3-puma', '~> 6.2'
end

run_bundle

run "bundle exec cap install"


domain  = ask('domain: ')
user    = ask('user: ')
repo    = ask('repository: ')

# Capistrano
# 分支
uncomment_lines 'config/deploy.rb', /ask\s+:branch/

# 项目名称
# @TODO: heyfong-crm / heyfong_crm(错误)
gsub_file 'config/deploy.rb', /(set\s+:application,).*/, "\\1 '#{app_name}'"

# 仓库地址
gsub_file 'config/deploy.rb', /(set\s+:repo_url,).*/, "\\1 '#{repo}'"

# 项目地址
gsub_file 'config/deploy.rb', /(#\s+)(set\s+:deploy_to,).*/, '\2 "/var/www/#{fetch(:application)}"'

# 服务器
prepend_to_file 'config/deploy/production.rb' do
"server '#{domain}', user: '#{user}', roles: %w{app db web}"
end

# Capistrano::Rbenv
uncomment_lines 'Capfile', /require.*rbenv/

append_to_file 'config/deploy.rb' do
  <<-EOS.strip_heredoc

  # rbenv
  set :rbenv_type, :user
  set :rbenv_ruby, '3.3.8'
  append :linked_files, ".rbenv-vars"
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
uncomment_lines 'config/deploy.rb', /append\s:linked_dirs/


# Capistrano::Puma
insert_into_file 'Capfile', :after => /require.*passenger.*\s/ do
  <<-EOS.strip_heredoc


    require 'capistrano/puma'
    install_plugin Capistrano::Puma
    install_plugin Capistrano::Puma::Systemd
  EOS
end


append_to_file 'config/deploy.rb' do
  <<-EOS.strip_heredoc

    set :puma_service_unit_name, 'heyfong-crm'
    set :puma_service_unit_env_files, '/var/www/heyfong-crm/shared/.rbenv-vars'
  EOS

end



git add: "."
git commit: %Q{ -m 'capistrano-rails' }

