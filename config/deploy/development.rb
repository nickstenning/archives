set :application, "archives-dev"
set :deploy_to, "/home/nick/rails/deploy/#{application}"
set :rails_env, "development"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  task :after_symlink do
    run "ln -nfs #{shared_path}/db/development.sqlite3 #{release_path}/db/development.sqlite3"
  end
end