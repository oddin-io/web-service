source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'

# Rails API
gem 'rails-api'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use AMS for JSON rendering
gem 'active_model_serializers', '~> 0.10.0'

# Paperclip for file upload and download
gem 'paperclip', '~> 5.0.0.beta1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.0', group: :doc

  # Use Capistrano for deployment
  # gem 'capistrano-rails', group: :development
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # annotate to comment the database models
  gem 'annotate'
end

group :test do
  # Test Suite
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'simplecov', require: false
  gem 'database_cleaner'
  gem 'shoulda-matchers', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

=begin
Paperclip is now compatible with aws-sdk >= 2.0.0.

If you are using S3 storage, aws-sdk >= 2.0.0 requires you to make a few small
changes:

* You must set the `s3_region`
* If you are explicitly setting permissions anywhere, such as in an initializer,
  note that the format of the permissions changed from using an underscore to
  using a hyphen. For example, `:public_read` needs to be changed to
  `public-read`.

For a walkthrough of upgrading from 4 to 5 and aws-sdk >= 2.0 you can watch
http://rubythursday.com/episodes/ruby-snack-27-upgrade-paperclip-and-aws-sdk-in-prep-for-rails-5
=end