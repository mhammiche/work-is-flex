require 'rails_helper'

RSpec.describe "booking_requests/new", type: :view do
  before(:each) do
    assign(:booking_request, BookingRequest.new())
  end

  it "renders new booking_request form" do
    render

    assert_select "form[action=?][method=?]", booking_requests_path, "post" do
    end
  end
end
