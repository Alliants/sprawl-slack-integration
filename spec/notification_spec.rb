require "spec_helper"

describe Notification do
  describe "#message" do
    it "returns a string with details of the event" do
      event = {
        "id" => 455,
        "event_type" => "pull_request",
        "action" => "closed",
        "payload" => {
          "link" => "https://github.com/Alliants/fs-reset-password/pull/2",
          "title" => "Validation Email Templates",
          "organization" => "Alliants",
          "repository" => "Alliants/fs-reset-password",
          "owner" => "jacksonhyde",
          "original_id" => 52_525_344,
          "created_at" => "2015-12-03T12:00:59Z",
          "number_of_comments" => 11,
          "action" => "closed"
        }
      }
      notification = described_class.new(event: event)

      expect(notification.message).to eq "jacksonhyde has closed a pull_request called <https://github.com/Alliants/fs-reset-password/pull/2|Validation Email Templates> on 'Alliants/fs-reset-password'"
    end
  end
end
