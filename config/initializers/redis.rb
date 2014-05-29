$redis = Redis.new

Thread.abort_on_exception = true

heartbeat_thread = Thread.new do
  puts "starting thread"
  while true
    puts "heartbeat!!"
    $redis.publish("status_update", "heartbeat")
    sleep 30.seconds
  end
end

at_exit do
  # not sure this is needed, but just in case
  heartbeat_thread.kill
  $redis.quit
end
