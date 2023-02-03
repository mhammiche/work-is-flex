# frozen_string_literal: true

class BookingRequestMailer < ApplicationMailer
  def email_verification
    @booking_request = params[:booking_request]
    @confirmation_url = confirm_booking_request_url(@booking_request, token: params[:token])

    mail(to: @booking_request.email, subject: 'Confirmation de votre adresse email')
  end

  def request_accepted
    @booking_request = params[:booking_request]
    @booking_request_url = booking_request_url(@booking_request)

    mail(to: @booking_request.email, subject: 'Votre demande a été accepté')
  end

  def request_declined
    @booking_request = params[:booking_request]
    @booking_request_url = booking_request_url(@booking_request)

    mail(to: @booking_request.email, subject: 'Votre demande a été refusé')
  end

  def contract_signed
    @booking_request = params[:booking_request]
    @booking_request_url = booking_request_url(@booking_request)

    mail(to: @booking_request.email, subject: 'Votre contrat a été signé')
  end
end
