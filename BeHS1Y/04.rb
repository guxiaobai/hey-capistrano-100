

# Capistrano::Puma
insert_into_file 'Capfile', :after => /require.*passenger.*\s/ do
  <<-EOS.strip_heredoc
    require 'capistrano/puma'
    install_plugin Capistrano::Puma
    install_plugin Capistrano::Puma::Nginx
    install_plugin Capistrano::Puma::Systemd
  EOS
end


insert_into_file 'config/deploy.rb' do
  <<-EOS.strip_heredoc

    set :puma_service_unit_env_file, '/etc/environment'
    set :puma_phased_restart, true
    set :puma_init_active_record, true


    set :nginx_server_name, "#{domain}"
  EOS
end

gsub_file 'config/deploy.rb', "config/database.yml", "coinfig/master.key"