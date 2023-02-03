class ExpirationReminderJob
  include Sidekiq::Job

  queue_as :default

  def perform(booking_request_id)
    request = BookingRequest.find_by(id: booking_request_id)
    return unless request

    if request.may_expire?
      BookingRequestMailer.with(booking_request: request).expiration_reminder.deliver_now
    end
  end
end