# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :invalid) unless URI::MailTo::EMAIL_REGEXP.match?(value)
  end
end
