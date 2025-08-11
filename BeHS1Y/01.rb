# https://github.com/seuros/capistrano-puma
set :nginx_sites_available_path, "/etc/nginx/sites-available"
set :nginx_sites_enabled_path, "/etc/nginx/sites-enabled"
set :nginx_server_name, "ipcrs.maidoulicai.cn"


# 微信支付证书
append :linked_files, "apiclient_cert.p12"


# capistrano-yarn

set :pty, false
set :sidekiq_concurrency, 5
set :sidekiq_queue, ['default']
# or use config.yml file
set :sidekiq_config, "config/sidekiq.yml"