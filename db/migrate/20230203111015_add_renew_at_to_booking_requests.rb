class AddRenewAtToBookingRequests < ActiveRecord::Migration[7.0]
  def change
    change_table :booking_requests do |t|
      t.datetime :renewed_at
    end
  end
end
