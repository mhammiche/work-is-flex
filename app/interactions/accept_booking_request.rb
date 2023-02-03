# frozen_string_literal: true

class AcceptBookingRequest < ActiveInteraction::Base
  record :booking_request

  def execute
    booking_request.accept!
    send_request_accepted
    booking_request
  end

  private

  def send_request_accepted
    BookingRequestMailer.with(booking_request: booking_request).request_accepted.deliver_later
  end
end