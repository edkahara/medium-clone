source 'https://rubygems.org'
ruby '2.2.6'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.7'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'friendly_id', '~> 5.1.0'
gem 'tinymce-rails'
gem 'devise'
gem 'client_side_validations'
gem 'carrierwave', '~> 1.0'
gem 'mini_magick'
gem 'file_validators'
gem 'tinymce-rails-imageupload', '~> 4.0.0.beta'
gem 'awesome_link'
gem 'acts-as-taggable-on', '~> 4.0'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'sqlite3'
  gem 'web-console', '>= 3.3.0'
end

group :production do
  gem 'pg'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
