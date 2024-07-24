class Current < ActiveSupport::CurrentAttributes
  attribute :session
  attribute :user_agent, :ip_address

  delegate :user, to: :session, allow_nil: true

  def user=(user)
    super
    Time.zone    = user.time_zone
  end
end
