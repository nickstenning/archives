set :application, "archives-prod"
set :deploy_to, "/home/nick/rails/deploy/#{application}"

role :app, domain
role :web, domain
role :db,  domain, :primary => true