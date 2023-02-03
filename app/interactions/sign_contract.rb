# frozen_string_literal: true

class SignContract < ActiveInteraction::Base
  record :booking_request

  def execute
    booking_request.sign!
    send_contract_signed
    booking_request
  end

  private

  def send_contract_signed
    BookingRequestMailer.with(booking_request: booking_request).contract_signed.deliver_later
  end
end