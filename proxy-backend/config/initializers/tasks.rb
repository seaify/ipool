require 'rufus/scheduler'

$redis = Redis.new(:host => 'localhost', :port => 6379)
## to start scheduler
scheduler = Rufus::Scheduler.start_new

## It will print message every i minute
scheduler.every("5m") do
  #flush redis to db
  puts("HELLO #{Time.now}")
end