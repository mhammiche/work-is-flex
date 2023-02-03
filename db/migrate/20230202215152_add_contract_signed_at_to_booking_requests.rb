# frozen_string_literal: true

class AddContractSignedAtToBookingRequests < ActiveRecord::Migration[7.0]
  def change
    change_table :booking_requests do |t|
      t.datetime :contract_signed_at
    end
  end
end
