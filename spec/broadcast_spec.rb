ENV["SLACK_INTEGRATION"] = "/services/123"

require "spec_helper"

describe Broadcast do
  describe ".perform" do
    it "notifies slack of a close pull request" do
      stub_request(:post, "https://hooks.slack.com/services/123")
        .with(body: '{ "text": "some message" }',
              headers: {
                "Accept" => "*/*",
                "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
                "Content-Type" => "application/json",
                "User-Agent" => "Faraday v0.9.2"
              })
        .to_return(status: 200, body: "", headers: {})

      Broadcast.process(double("notification", message: "some message"))

      expect(WebMock).to have_requested(:post, "https://hooks.slack.com/services/123")
        .with { |req| JSON.parse(req.body).fetch("text") == "some message" }
    end
  end
end
