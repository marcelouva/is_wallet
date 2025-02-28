require 'logger'
require "sinatra/activerecord/rake"
require 'rake'

namespace :db do
  task :load_config do
    require "./app"
  end
end
