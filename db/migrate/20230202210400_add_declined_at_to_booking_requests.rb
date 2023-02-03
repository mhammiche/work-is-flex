# frozen_string_literal: true

class AddDeclinedAtToBookingRequests < ActiveRecord::Migration[7.0]
  def change
    change_table :booking_requests do |t|
      t.datetime :declined_at
    end
  end
end
