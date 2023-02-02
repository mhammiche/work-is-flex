# frozen_string_literal: true

class BookingRequestsController < ApplicationController
  before_action :set_booking_request, only: %i[show edit update confirm]

  # GET /booking_requests or /booking_requests.json
  def index
    @booking_requests = BookingRequest.all
  end

  # GET /booking_requests/1 or /booking_requests/1.json
  def show; end

  # GET /booking_requests/new
  def new
    @booking_request = BookingRequest.new
  end

  # GET /booking_requests/1/edit
  def edit; end

  # POST /booking_requests or /booking_requests.json
  def create
    @booking_request = BookingRequest.new(booking_request_params)

    respond_to do |format|
      if @booking_request.save
        format.html do
          redirect_to booking_request_url(@booking_request), notice: I18n.t('booking_request.events.created')
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /booking_requests/1 or /booking_requests/1.json
  def update
    respond_to do |format|
      if @booking_request.update(booking_request_params)
        format.html do
          redirect_to booking_request_url(@booking_request), notice: I18n.t('notifications.booking_request_confirmed')
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # POST /booking_requests/1 or /booking_requests/1.json
  def confirm
    outcome = ConfirmBookingRequest.run(booking_request: @booking_request, token: params[:token])
    respond_to do |format|
      if outcome.valid?
        format.html do
          redirect_to booking_request_url(@booking_request), notice: I18n.t('booking_request.events.confirmed')
        end
      else
        format.html { redirect_to home_url, error: 'Le lien de confirmation est invalide' }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_booking_request
    @booking_request = BookingRequest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def booking_request_params
    params.require(:booking_request).permit(:name, :email, :phone, :biography)
  end
end
