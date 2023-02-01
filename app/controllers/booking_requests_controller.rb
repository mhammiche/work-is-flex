class BookingRequestsController < ApplicationController
  before_action :set_booking_request, only: %i[ show edit update destroy ]

  # GET /booking_requests or /booking_requests.json
  def index
    @booking_requests = BookingRequest.all
  end

  # GET /booking_requests/1 or /booking_requests/1.json
  def show
  end

  # GET /booking_requests/new
  def new
    @booking_request = BookingRequest.new
  end

  # GET /booking_requests/1/edit
  def edit
  end

  # POST /booking_requests or /booking_requests.json
  def create
    @booking_request = BookingRequest.new(booking_request_params)

    respond_to do |format|
      if @booking_request.save
        format.html { redirect_to booking_request_url(@booking_request), notice: I18n.t('notifications.booking_request_created') }
        format.json { render :show, status: :created, location: @booking_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @booking_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /booking_requests/1 or /booking_requests/1.json
  def update
    respond_to do |format|
      if @booking_request.update(booking_request_params)
        format.html { redirect_to booking_request_url(@booking_request), notice: "Booking request was successfully updated." }
        format.json { render :show, status: :ok, location: @booking_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @booking_request.errors, status: :unprocessable_entity }
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
