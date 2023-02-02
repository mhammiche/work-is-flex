# frozen_string_literal: true

class ConfirmBookingRequest < ActiveInteraction::Base
  record :booking_request
  string :token, default: nil

  def execute
    booking_request.confirm!
  end
end
