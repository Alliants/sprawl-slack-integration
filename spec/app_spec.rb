require "spec_helper"

describe "Cuba" do
  describe "/notification" do
    it "registers a new notification" do
      message = { "event_type" => "pull_request", "payload" => { "owner" => "Joe" } }

      expect(Broadcast).to receive(:process)
        .with(Notification.new(event: message))
      post "/notification", source: "http://some.source", message: message.to_json

      expect(last_response.body).to eq "message received"
    end
  end
end
