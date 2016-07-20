class Notification
  class PullRequestMessage
    def self.generate_message_for(event)
      "#{event.dig('payload', 'owner')} has #{event.fetch('action', 'unknown')} a #{event.fetch('event_type', 'unknown')} called <#{event.dig('payload', 'link')}|#{event.dig('payload', 'title')}> on '#{event.dig('payload', 'repository')}'"
    end
  end

  class WeeklyPullRequestReportMessage
    def self.generate_message_for(event)
      start_date = Time.parse(event.dig("payload", "start_date")).strftime("%d/%m/%Y")
      end_date = Time.parse(event.dig("payload", "end_date")).strftime("%d/%m/%Y")

      "Between #{start_date} and #{end_date} this is the pull request activity: \n  * opened #{event.dig("payload", "pull_request_opened")} \n * closed #{event.dig("payload", "pull_request_closed")} \n * merged #{event.dig("payload", "pull_request_merged")} \n Great work everyone!"
    end
  end

  class NullMessage
    def self.generate_message_for(event)
      nil
    end
  end

  TYPES_MAPPER = {
    "pull_request" => PullRequestMessage,
    "weekly_report" => WeeklyPullRequestReportMessage
  }

  def initialize(event:)
    @event = event
  end

  def message
    TYPES_MAPPER.fetch(event.fetch("event_type"), NullMessage).generate_message_for(event)
  end

  def ==(other)
    message == other.message
  end

  private

  attr_reader :event
end
