require 'bundler/capistrano'

set :deploy_to, "/var/www/memoizr"
set :rails_env, "production"
set :user, 'memoizr'
set :runner, 'memoizr'
set :application, "memoizr"
set :use_sudo, false
role :app, "173.255.210.71"
role :web, "173.255.210.71"
role :db,  "173.255.210.71", :primary => true

set :scm, :git
set :repository, "git@github.com:railsrumble/rr10-team-222.git"
set :branch, "master"
ssh_options[:forward_agent] = true

default_environment["PATH"] = "/opt/ruby-enterprise-1.8.7-2010.02/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/ruby-enterprise-1.8.7-2010.02/lib/ruby/gems/1.8/"

after 'deploy:update', 'save_deploy_date'
after 'deploy:update_code', 'update_symlinks'

namespace :deploy do
  desc "Restart application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

desc "Save deploy date to log"
task :save_deploy_date do
   run "cd #{deploy_to}/current/log; date '+deploy_date: %Y-%m-%d %H:%M' > deploy_date.log"
end

desc "Link the proper configuration files"
task :update_symlinks do
  run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  #run "ln -nfs #{deploy_to}/shared/config/application.yml #{release_path}/config/application.yml"
end

        require 'config/boot'
        require 'hoptoad_notifier/capistrano'
