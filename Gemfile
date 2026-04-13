source "https://rubygems.org"

gem "rails", "~> 7.2.3"
gem "sprockets-rails"
gem "mysql2", "~> 0.5"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "faker"
gem "stripe"
gem "dotenv-rails", groups: [:development, :test]
gem "image_processing", "~> 1.2"
# Auth
gem "devise"

# Admin dashboard
gem "activeadmin"

# Pagination (use kaminari NOT will_paginate - they conflict)
gem "kaminari"

# Bootstrap 5
gem "bootstrap", "~> 5.3"
gem "sassc-rails"

# Image processing for Active Storage
gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end