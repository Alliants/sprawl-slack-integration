class Notification
  class PullRequestMessage
    def self.generate_message_for(event)
      "#{event.dig('payload', 'owner')} has #{event.fetch('action', 'unknown')} a #{event.fetch('event_type', 'unknown')} called <#{event.dig('payload', 'link')}|#{event.dig('payload', 'title')}> on '#{event.dig('payload', 'repository')}'"
    end
  end

  class NullMessage
    def self.generate_message_for(event)
      nil
    end
  end

  TYPES_MAPPER = {
    "pull_request" => PullRequestMessage
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
