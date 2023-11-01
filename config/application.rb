require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Backend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.active_job.queue_adapter = :sidekiq
    config.default_url_options = { host: ENV['BACKEND_HOST_NAME'], port: 3000 }
    config.hosts << ENV['ALLOWED_FRONTEND_HOSTS']
    # Configure CORS
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins ENV['CORS_ORIGIN'] # replace with the domain(s) you want to allow requests from
        resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end
  
    protected

    def after_sign_in_path_for(resource)
      # Modify this path to your desired URL      
            
      member_details_path # Replace 'root_path' with your desired URL path
    end
    def after_sign_out_path_for(resource_or_scope)
      # Modify this path to your desired URL
      root_path # Replace 'root_path' with your desired URL path
    end

    # config.session_store :cookie_store, key: '_interslice_session'
    # config.middleware.use ActionDispatch::Cookies
    # config.middleware.use config.session_store, config.session_options
    
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
