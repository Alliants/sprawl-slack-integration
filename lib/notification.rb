class Notification
  def initialize(event:)
    @event = event
  end

  def message
    "#{event.dig('payload', 'owner')} has #{event.fetch('action', 'unknown')} a #{event.fetch('event_type', 'unknown')} called <#{event.dig('payload', 'link')}|#{event.dig('payload', 'title')}> on '#{event.dig('payload', 'repository')}'"
  end

  def ==(other)
    message == other.message
  end

  private

  attr_reader :event
end
