
source 'https://rubygems.org'
ruby "2.0.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'
# Use postgresql as the database for Active Record
#gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

#progress bar for page load
gem 'nprogress-rails'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

#image uploader
gem "paperclip", "~> 4.3"

#image storage
gem "paperclip-dropbox", ">= 1.1.7"

#hide information
gem "figaro"

#payments API
gem 'stripe'

#Use unicorn as the app server
gem 'unicorn'

# server timeout
gem 'rack-timeout'

gem 'bundler'

gem 'validates_formatting_of'
gem 'tzinfo-data'
gem 'devise', github: 'plataformatec/devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'google-analytics-rails'
gem 'bootstrap-sass', '3.3.5'
gem 'bootstrap-sass-extras'
gem 'activeadmin', github: 'gregbell/active_admin'



group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'pg'
end

group :test do
  gem 'shoulda-matchers'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
end
