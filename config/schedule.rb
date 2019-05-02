require File.expand_path(File.dirname(__FILE__) + "/environment")
set :output, "#{Rails.root}/log/cron.log"
env :PATH, ENV['PATH']
ENV['RAILS_ENV'] ||= "development"
set :environment, ENV['RAILS_ENV']

every 1.minutes do
    rake "get_entry:feeds"
end