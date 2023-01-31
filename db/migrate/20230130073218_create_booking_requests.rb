# frozen_string_literal: true

class CreateBookingRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :booking_requests, id: :uuid do |t|
      t.string :email, null: false, index: true
      t.string :name
      t.string :phone
      t.text :biography
      t.string :state, null: false, index: true

      t.datetime :confirmed_at, index: true
      t.datetime :accepted_at
      t.datetime :expired_at
      t.timestamps
    end
  end
end
