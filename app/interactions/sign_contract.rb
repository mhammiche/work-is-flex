# frozen_string_literal: true

class SignContract < ActiveInteraction::Base
  record :booking_request

  def execute
    booking_request.sign!
    send_contract_signed
    schedule_contract_expiration
    booking_request
  end

  private

  def send_contract_signed
    BookingRequestMailer.with(booking_request: booking_request).contract_signed.deliver_later
  end

  def schedule_contract_expiration
    expire_at = booking_request.contract_expire_at
    renew_at = booking_request.renewing_period.begin
    ExpirationReminderJob.perform_at(renew_at, booking_request.id)
    ExpireContractJob.perform_at(expire_at, booking_request.id)
  end
end