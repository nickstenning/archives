set :application, "archives-staging"
set :deploy_to, "/home/nick/rails/deploy/#{application}"
set :rails_env, "staging"

role :app, domain
role :web, domain
role :db,  domain, :primary => true