require "pi_piper"
require 'redis'

redis = Redis.new

PiPiper.watch(pin: 7, direction: :in) do
  # 1 - door close
  # 0 - door open

  if value == 1
    redis.set('status', "occupied")
    redis.publish('status_update', "occupied")
  elsif value == 0
    redis.set('status', "available")
    redis.publish('status_update', "available")
  end

  puts "Pin changed from #{last_value} to #{value}"
end

PiPiper.wait
