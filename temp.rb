# === Requirements ==========================================================

require 'json'
require 'postageapp'

# === Configuration =========================================================

PROJECT_API = "QtsgBKkcCbeOkDRvsKU5lR9Vxa8hfQiC"
PING_INTERVAL = 5
REPORT_INTERVAL = 120

PostageApp.configure do |config|
  config.api_key = PROJECT_API
end

# === Loop ==================================================================

loop do
  pings = [ ]
  stop = false

  timer_thread = Thread.new do
    sleep REPORT_INTERVAL
    stop = true
  end

  request_thread = Thread.new do
    until stop do
      sleep PING_INTERVAL

      request = PostageApp::Request.new(:get_project_info)

      response = request.send

      pings << response.status == "ok"
    end
  end

  timer_thread.join
  request_thread.join

  results = {
    timestamp: Time.now,
    responses: pings.count,
    successes: pings.count { |r| r == "ok" }
  }

  results[:success_percentage] = (results[:successes].to_f / results[:responses].to_f) * 100

  File.open("results.txt", "a") do |f|
    f.puts results.to_json
  end
end
