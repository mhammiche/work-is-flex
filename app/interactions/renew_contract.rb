# frozen_string_literal: true

class RenewContract < ActiveInteraction::Base
  record :booking_request

  def execute
    booking_request.renew!
    schedule_contract_expiration
    booking_request
  end

  private

  def schedule_contract_expiration
    expire_at = booking_request.contract_expire_at
    renew_at = booking_request.renewing_period.begin
    ExpirationReminderJob.perform_at(renew_at, booking_request.id)
    ExpireContractJob.perform_at(expire_at, booking_request.id)
  end
end