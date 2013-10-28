require 'bundler/capistrano'

set :application, "studentapp"
set :repository,  "git@github.com:rayning0/sinatra-students-ruby-003.git"

set :user, 'deploy'
set :deploy_to, "/home/#{ user }/#{ application }"
set :use_sudo, false
set :branch, fetch(:branch, "deploy")

set :scm, :git

default_run_options[:pty] = true

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "162.243.77.169"                          # Your HTTP server, Apache/etc
role :app, "162.243.77.169"                          # This may be the same as your `Web` server
role :db,  "162.243.77.169", :primary => true        # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
before "deploy:restart", "deploy:symlink_database"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :symlink_database, :roles => :app do
    run "ln -nfs #{shared_path}/students-production.db #{current_path}/db/students-production.db"
  end
  task :migrate, :roles => :app do 
    run "cd #{current_path} && rake db:migrate RACK_ENV=production"
  end

  task :scrape_students, :roles => :app do
    run "cd #{current_path} && rake scrape_students RACK_ENV=production"
  end
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end