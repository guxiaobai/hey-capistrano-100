# Capistrano

```bash
cap production puma:install
```


# Capistrano::Puma

```bash
# ~/.config/systemd/user/

/bin/systemctl --user daemon-reload
/bin/systemctl --user enable equestia-api
/bin/systemctl --user enable equestia-api.socket
```


## Ref


* [capistrano-rails](https://github.com/capistrano/rails)
* [capistrano-rbenv](https://github.com/capistrano/rbenv)
* [capistrano-bundler](https://github.com/capistrano/bundler)
* [capistrano3-puma](https://github.com/seuros/capistrano-puma)
* [capistrano-sidekiq](https://github.com/seuros/capistrano-sidekiq)