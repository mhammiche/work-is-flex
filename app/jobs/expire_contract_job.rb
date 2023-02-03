class ExpireContractJob
  include Sidekiq::Job

  queue_as :default

  def perform(booking_request_id)
    request = BookingRequest.find_by(id: booking_request_id)
    return unless request

    if request.accepted?
      # Expires immediately (The contract was not signed yet)
      request.expire!
    elsif request.may_expire? && request.will_expire_now?
      request.expire!
    end
  end
end