# frozen_string_literal: true

class DeclineBookingRequest < ActiveInteraction::Base
  record :booking_request

  def execute
    booking_request.decline!
    send_request_declined
    booking_request
  end

  private

  def send_request_declined
    BookingRequestMailer.with(booking_request: booking_request).request_declined.deliver_later
  end
end