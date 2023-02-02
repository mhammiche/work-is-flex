# frozen_string_literal: true

class BookingRequest < ApplicationRecord
  include AASM

  BIO_MIN_WORDS = 5

  validates :name, presence: true
  validates :email, email: true
  validates :phone, phone: true
  validate :biography_is_good_enough

  after_validation :normalize_phone

  after_commit :send_email_verification, on: :create

  aasm column: 'state', timestamps: true do
    state :unconfirmed, initial: true
    state :confirmed
    state :accepted
    state :expired

    event :confirm do
      transitions from: :unconfirmed, to: :confirmed
    end
  end

  # Redefine confirmed scope to sort by confirmation date
  scope :confirmed, -> { where(state: BookingRequest::STATE_CONFIRMED).order(:confirmed_at) }

  def send_email_verification
    BookingRequestMailer.with(booking_request: self, token: 'FOO').email_verification.deliver_later
  end

  private

  def normalize_phone
    self.phone = Phonelib.parse(phone).full_e164.presence
  end

  def biography_is_good_enough
    errors.add(:biography, :invalid) if biography.to_s.split(/\W/).length < BIO_MIN_WORDS
  end
end
