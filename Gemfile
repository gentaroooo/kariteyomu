source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.6', '>= 6.1.6.1'
# Use sqlite3 as the database for Active Record
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'uglifier', '>= 1.3.0'

gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'faker'
  gem 'factory_bot_rails'
  # 変更しないでください
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-checkstyle_formatter'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'sqlite3'
  ## ここまで
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'
  # gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener_web', '2.0'
end

group :test do
  gem 'capybara'
  gem 'webdrivers'
end

# 本番環境用のgemグループを新しく作成しPostgresを指定
group :production do
  gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


# uninitialized constant Mail::TestMailerの対策
gem 'net-smtp'
gem 'net-imap'
gem 'net-pop'

# gem 'bootsnap', '>= 1.4.4', require: false
gem 'bootstrap', '~> 4.3.1'

gem 'dotenv-rails'
gem 'font-awesome-sass', '~> 5.11.2'
gem 'jquery-rails'

gem 'sorcery', '0.16.3'
gem 'pry-byebug'
gem 'draper', '4.0.0'
# gem 'carrierwave', '2.2.2'
gem 'carrierwave', '~> 2.0.2'
gem 'mini_magick'
gem 'cloudinary'
gem 'kaminari', '1.2.2'
gem 'ransack', '2.3.0'
gem 'config', '2.2.1'
gem 'enum_help', '0.0.17'
gem 'faraday'
gem 'rails-i18n'
gem 'ancestry'
gem 'gon'