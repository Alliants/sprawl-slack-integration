require "spec_helper"

describe "Cuba" do
  describe "/notification" do
    it "registers a new notification" do
      message = { "foo" => "bar" }
      expect(Broadcast).to receive(:process)
        .with(Notification.new(source: "example.org", message: message))
      post "/notification", payload: message

      expect(last_response.body).to eq "message received"
    end
  end
end
