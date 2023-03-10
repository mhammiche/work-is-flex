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
    state :contract_signed
    state :expired
    state :declined

    event :confirm do
      transitions from: :unconfirmed, to: :confirmed
    end

    event :accept do
      transitions from: :confirmed, to: :accepted
    end

    event :sign do
      transitions from: :accepted, to: :contract_signed
    end

    event :decline do
      transitions from: :confirmed, to: :declined
    end

    event :expire do
      transitions from: :accepted, to: :expired
    end

    event :renew do
      transitions from: :contract_signed,
        to: :contract_signed,
        after: :touch_renewed_at,
        guard: :will_expire_soon?
    end
  end

  # Redefine confirmed scope to sort by confirmation date
  scope :confirmed, -> { where(state: BookingRequest::STATE_CONFIRMED).order(:confirmed_at) }

  # Group state accepted and contract_signed
  scope :accepted, -> { where(state: [BookingRequest::STATE_ACCEPTED, BookingRequest::STATE_CONTRACT_SIGNED,]).order(:accepted_at) }


  def signature_required?
    accepted? && !contract_signed_at
  end

  def contract_expire_at
    return nil unless contract_signed?

    (renewed_at || accepted_at) + 3.months
  end

  def renewing_period
    beginning = contract_expire_at - 10.days
    beginning..contract_expire_at
  end

  def will_expire_soon?
    return false unless contract_signed?

    renewing_period.cover?(Time.zone.now)
  end

  def will_expire_now?
    return false unless contract_signed?

    contract_expire_at <= Time.zone.now
  end

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

  def touch_renewed_at
    self.renewed_at = Time.zone.now
  end
end
