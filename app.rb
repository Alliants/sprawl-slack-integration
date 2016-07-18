$LOAD_PATH.unshift File.dirname(__FILE__)

require "cuba"
require "json"

require "lib/broadcast"
require "lib/notification"

Cuba.define do
  on get do
    on "health" do
      res.write({ status: "ok" }.to_json)
    end
  end

  on post do
    on "notification" do
      on param("source"), param("message") do |_, message|
        notification = Notification.new(event: JSON.parse(message))
        Broadcast.process(notification)
        res.write "message received"
      end

      on true do
        res.write "Please provide source and message"
      end
    end
  end
end
