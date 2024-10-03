class SendFollowUpEmailJob < ApplicationJob
  queue_as :default

  def perform(email)
    # Do something later
    AccountMailer.follow_up_email(email).deliver_now
  end
end
