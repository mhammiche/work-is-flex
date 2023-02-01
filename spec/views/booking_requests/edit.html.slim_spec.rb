require 'rails_helper'

RSpec.describe "booking_requests/edit", type: :view do
  let(:booking_request) {
    BookingRequest.create!()
  }

  before(:each) do
    assign(:booking_request, booking_request)
  end

  it "renders the edit booking_request form" do
    render

    assert_select "form[action=?][method=?]", booking_request_path(booking_request), "post" do
    end
  end
end
