require "faraday"

class Broadcast
  def self.process(notification)
    conn = Faraday.new(url: "https://hooks.slack.com") do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    message = notification.message

    conn.post do |req|
      req.url ENV["SLACK_INTEGRATION"]
      req.headers["Content-Type"] = "application/json"
      req.body = "{ \"text\": \"#{message}\" }"
    end unless message.nil?
  end
end
