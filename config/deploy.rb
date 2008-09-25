set :stages,        %w(staging production)
set :default_stage, 'staging'

require 'capistrano/ext/multistage'

set :domain,      "antonio"
set :repository,  "http://antonio.adctheatre.com/svn/archives/trunk"
set :use_sudo,    false

ssh_options[:compression] = false

namespace :deploy do
  
  desc "Restart Phusion Passenger with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Stop task is a deploy.web.disable with Phusion Passenger"
  task :stop, :roles => :app do
    deploy.web.disable
  end

  desc "Start task is a deploy.web.enable with Phusion Passenger"
  task :start, :roles => :app do
    deploy.web.enable
  end
  
  task :after_update_code, :roles => :app do
     copy_database_configuration
  end

  task :copy_database_configuration do
    run "cp /home/nick/rails/etc/archives-database.yml #{release_path}/config/database.yml"
    run "chmod 0444 #{release_path}/config/database.yml"
  end
  
end