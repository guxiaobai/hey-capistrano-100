# capistrano

domain  = ask('domain: ')
user    = ask('user: ')
repo    = ask('repository: ')

# stage: production
prepend_to_file 'config/deploy/production.rb' do
"server '#{domain}', user: '#{user}', roles: %w{app db web}"
end

# config/deploy.rb
gsub_file 'config/deploy.rb', /(set\s+:application,).*/, "\\1 '#{app_name}'"
gsub_file 'config/deploy.rb', /(set\s+:repo_url,).*/, "\\1 '#{repo}'"

uncomment_lines 'config/deploy.rb', /ask\s+:branch/
gsub_file 'config/deploy.rb', /(#\s+)(set\s+:deploy_to,).*/, '\2 "/var/www/#{fetch(:application)}"'

uncomment_lines 'config/deploy.rb', /append\s:linked_dirs/

 
 
