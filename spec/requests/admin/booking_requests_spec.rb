require 'rails_helper'

RSpec.describe "Admin::BookingRequests", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/booking_requests/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /accept" do
    it "returns http success" do
      get "/admin/booking_requests/accept"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /decline" do
    it "returns http success" do
      get "/admin/booking_requests/decline"
      expect(response).to have_http_status(:success)
    end
  end

end
