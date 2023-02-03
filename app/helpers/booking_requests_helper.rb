# frozen_string_literal: true

module BookingRequestsHelper
  STATE_STYLES = {
    unconfirmed: 'is-warning',
    confirmed: 'is-info',
    accepted: 'is-info',
    contract_signed: 'is-success',
    expired: 'is-danger'
  }.with_indifferent_access.freeze

  def status_label(state)
    I18n.t("booking_request.states.#{state}.label")
  end

  def status_tag(state)
    style = STATE_STYLES[state]
    tag.span status_label(state), class: "tag #{style}"
  end

  def contract_status(date)
    if date
      tag.span "Signé", class: "tag is-info"
    else
      tag.span "Non Signé", class: "tag is-warning"
    end
  end
end
