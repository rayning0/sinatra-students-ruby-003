# This is the main application controller. It is mounted as the Rack application
# in config.ru. The purpose of this class is to provide an inheritance point for
# the rest of our controllers.

# Do not code routes or controller actions within this class.

class ApplicationController < Sinatra::Base
  # A custom view path to support a more MVC structure.
  # This will point all views to app/views, leaving you to specify
  # the controller subfolder and the view when rendering erb.
  # See the example in students_controller.rb, get '/'.
  set :views, File.expand_path('../../views', __FILE__)
  
  # A quick method to add all our app files to the reloader
  def self.reload_dirs(array)
    array.each do |dir|
      Dir.entries(dir).each do |file|
        next if file.start_with?(".")
        also_reload "./#{dir}/#{file}"
      end
    end
  end
  
  # Methods in controllers that aren't actions (endpoints for our routes)
  # should be made private.
  private_class_method :reload_dirs # This is native Ruby.
  
  # Configure Sinatra to reload directories like models and controllers.
  configure :development, :test do
    register Sinatra::Reloader
    reload_dirs ['app/concerns', 'app/models', 'app/controllers']
  end

  configure :production do
    set :dump_errors, true
    set :show_exceptions, true
  end
end