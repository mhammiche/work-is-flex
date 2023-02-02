# frozen_string_literal: true

module BookingRequestsHelper
  STATE_STYLES = {
    unconfirmed: 'is-warning',
    confirmed: 'is-info',
    accepted: 'is-success',
    expired: 'is-danger'
  }.with_indifferent_access.freeze

  def status_label(state)
    I18n.t("booking_request.states.#{state}.label")
  end

  def status_tag(state)
    style = STATE_STYLES[state]
    tag.span status_label(state), class: "tag #{style}"
  end
end
