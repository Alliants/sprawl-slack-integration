require "spec_helper"

describe Notification do
  describe "#message" do
    describe "pull_request events" do
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

      expect(notification.message).to eq "jacksonhyde has closed a pull_request called <https://github.com/Alliants/fs-reset-password/pull/2|Validation Email Templates> on <https://github.com/Alliants/fs-reset-password|Alliants/fs-reset-password>"
      end
    end

    describe "weekly_report events" do
      it "returns a string with details of the event" do
        event = {
          "event_type" => "weekly_report",
          "action" => "closed",
          "payload" => {
            "start_date" => "2015-12-03T12:00:59Z",
            "end_date" => "2015-12-10T12:00:59Z",
            "pull_request_opened" => 10,
            "pull_request_closed" => 20,
            "pull_request_merged" => 30,
          }
        }
        notification = described_class.new(event: event)

        expect(notification.message).to eq "Between 03/12/2015 and 10/12/2015 this is the pull request activity: \n  * opened 10 \n * closed 20 \n * merged 30 \n Great work everyone!"
      end
    end
  end
end
