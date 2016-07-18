class Notification
  def initialize(event:)
    @event = event
  end

  def message
    "#{event.dig('payload','owner')} has #{event.fetch('action')} a #{event.fetch('event_type')} called <#{event.dig('payload', 'link')}|#{event.dig('payload', 'title')}> on '#{event.dig('payload', 'repository')}'"
  end

  private

  attr_reader :event
end
