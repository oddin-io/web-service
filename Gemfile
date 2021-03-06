source 'https://rubygems.org'
ruby '2.5.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'

# Use Puma as the app server
gem 'puma', '~> 3.0'

# Render JSON views with ActiveModelSerializer
gem 'active_model_serializers', '~> 0.10.0'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# AWS SDK for update files
gem 'aws-sdk', '~> 2'

# Mailgun to send emails
gem 'mailgun-ruby', '~>1.1.0', require: 'mailgun'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  # Better console for Rails
  gem 'pry-rails'

  # Load .env files
  gem 'dotenv-rails'

  # Comment models and related files
  gem 'annotate', '~> 2.7', '>= 2.7.1'

  # Test frameworks
  gem 'rspec-rails'

  # Test support
  gem 'factory_bot_rails'
  gem 'factory_bot'
  gem 'faker', group: :production
  gem 'database_cleaner'
  gem 'shoulda-matchers', require: false
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
