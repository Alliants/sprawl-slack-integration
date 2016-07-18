$LOAD_PATH.unshift File.dirname(__FILE__)

require "cuba"

require "lib/broadcast"
require "lib/notification"

Cuba.define do
  on get do
    on "health" do
      res.write({status: "ok"}.to_json)
    end
  end

  on post do
    on "notification" do
      on param("payload") do |payload|
        notification = Notification.new(source: req.host, message: payload)
        Broadcast.process(notification)
        res.write "message received"
      end

      on true do
        res.write "Please provide a payload"
      end
    end
  end
end
