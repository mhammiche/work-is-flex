# frozen_string_literal: true

class AcceptBookingRequest < ActiveInteraction::Base
  record :booking_request

  def execute
    booking_request.accept!
    send_request_accepted
    schedule_contract_expiration
    booking_request
  end

  private

  def send_request_accepted
    BookingRequestMailer.with(booking_request: booking_request).request_accepted.deliver_later
  end

  def schedule_contract_expiration
    ExpireContractJob.perform_in(48.hours, booking_request.id)
  end
end