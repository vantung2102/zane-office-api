source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Server
ruby "3.1.2"
gem "rails", "~> 7.0.5"
gem "puma", "~> 5.0"
gem "bootsnap", require: false
gem 'bcrypt'

# Database and modle
gem "pg", "~> 1.1"

# Api serializers
gem 'blueprinter'

# seed data
gem 'seedbank'

# Policy and Role
gem 'pundit'
gem 'rolify'

# jwt json token
gem 'jwt'

# Pagination
gem 'pagy'

# Front-End
gem 'slim'

# routes
gem 'rswag'

# Active Storage
gem "image_processing", ">= 1.2"

# Countries
gem 'countries', '~> 5.5'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'pry-rails'
  gem 'dotenv-rails'
end

group :development do
  gem 'rubocop', require: false
  gem 'letter_opener'
  gem 'annotate'
end

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
