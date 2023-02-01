require 'rails_helper'

RSpec.describe "booking_requests/show", type: :view do
  before(:each) do
    assign(:booking_request, BookingRequest.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
