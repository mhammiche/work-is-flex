require 'rails_helper'

RSpec.describe "booking_requests/index", type: :view do
  before(:each) do
    assign(:booking_requests, [
      BookingRequest.create!(),
      BookingRequest.create!()
    ])
  end

  it "renders a list of booking_requests" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
