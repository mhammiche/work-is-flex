# frozen_string_literal: true

class BookingRequestMailer < ApplicationMailer
  def email_verification
    @booking_request = params[:booking_request]
    @confirmation_url = confirm_booking_request_url(@booking_request, token: params[:token])

    mail(to: @booking_request.email, subject: 'Confirmation de votre adresse email')
  end
end
