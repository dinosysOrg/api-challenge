source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "jbuilder", "~> 2.5"
gem "pg", "~> 0.18"
gem "puma", "~> 3.7"
gem "rack-attack"
gem "rack-cors"
gem "rails", "~> 5.1.6"

group :test do
  gem "database_cleaner"
  gem "factory_bot_rails", "~> 4.0"
  gem "faker"
  gem "shoulda-matchers", "~> 3.1"
end

group :development, :test do
  gem "byebug", platforms: %i(mri mingw x64_mingw)
  gem "rspec-rails", "~> 3.5"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop", "0.52.1"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)
