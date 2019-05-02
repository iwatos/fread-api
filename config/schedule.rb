require File.expand_path(File.dirname(__FILE__) + "/environment")
set :output, "/path/to/my/cron_log.log"

ENV['RAILS_ENV'] ||= "development"
set :environment, ENV['RAILS_ENV']

every 1.minutes do
    rake "sync:feeds"
end