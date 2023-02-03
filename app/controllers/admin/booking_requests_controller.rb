class Admin::BookingRequestsController < ApplicationController
  before_action :set_booking_request, only: %i[accept decline]

  def index
    @confirmed_requests = BookingRequest.confirmed
    @accepted_requests = BookingRequest.accepted
  end

  def accept
    outcome = AcceptBookingRequest.run(booking_request: @booking_request)

    respond_to do |format|
      if outcome.valid?
        format.html { redirect_to admin_booking_requests_path, notice:  I18n.t('booking_request.events.accepted') }
      else
        format.html { redirect_to admin_booking_requests_path, alert: outcome.errors.full_messages.join(', ') }
      end
    end
  end

  def decline
    outcome = DeclineBookingRequest.run(booking_request: @booking_request)

    respond_to do |format|
      if outcome.valid?
        format.html { redirect_to admin_booking_requests_path, notice: I18n.t('booking_request.events.declined') }
      else
        format.html { redirect_to admin_booking_requests_path, alert: outcome.errors.full_messages.join(', ') }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_booking_request
    @booking_request = BookingRequest.find(params[:id])
  end
end
