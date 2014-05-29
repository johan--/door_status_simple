class PagesController < ApplicationController
  include ActionController::Live

  def status
    redis = Redis.new
    @status = redis.get("status") || "unknown"
  end

  def updates
    response.headers["Content-Type"] = "text/event-stream"

    redis = Redis.new
    redis.subscribe('status_update') do |on|
      on.message do |event, data|
        if %w(available occupied).include? data
          data = { event: "status_update", status: data }
        else
          data = { event: "heartbeat" }
        end
        response.stream.write("data: #{data.to_json}\n\n")
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure
    response.stream.close
  end
end
