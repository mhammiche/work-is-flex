json.extract! booking_request, :id, :created_at, :updated_at
json.url booking_request_url(booking_request, format: :json)
