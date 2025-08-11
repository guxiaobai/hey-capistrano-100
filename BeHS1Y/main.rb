gem_group :development do
  gem 'capistrano-rails', '~> 1.7'
end

run_bundle

run "bundle exec cap install"

git add: "."
git commit: %Q{ -m 'capistrano-rails' }