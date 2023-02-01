module BookingRequestsHelper
  def status_tag(state)
    case state
    when 'unconfirmed'
      tag.span 'Non confirmée', class: 'tag is-warning'
    when 'confirmed'
      tag.span 'Confirmée', class: 'tag is-info'
    when 'accepted'
      tag.span 'Acceptée', class: 'tag is-success'
    when 'expired'
      tag.span 'Expirée', class: 'tag is-danger'
    end
  end
end
