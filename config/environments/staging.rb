# Settings specified here will take precedence over those in config/environment.rb

# Don't reload code between requests.
config.cache_classes = true

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Full error reports are enabled, unlike the production environment.
config.action_controller.consider_all_requests_local = true
# Caching is turned on.
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true

# Use a different cache store in production
# config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

# Don't log everything (DB queries, etc.)
config.log_level = :info
