# frozen_string_literal: true

FactoryBot.define do
  factory :booking_request do
    sequence(:email) { |n| "jdoe#{n}@example.com" }
    name { 'John Doe' }
    phone { '+33123456789' }
    biography { 'I am a good enough description' }
    state { 'unconfirmed' }

    trait :unconfirmed do
      state { 'unconfirmed' }
    end

    trait :confirmed do
      state { 'confirmed' }
      confirmed_at { Time.zone.now }
    end
  end
end
