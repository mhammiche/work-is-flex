require "rails_helper"

RSpec.describe BookingRequestsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/booking_requests").to route_to("booking_requests#index")
    end

    it "routes to #new" do
      expect(get: "/booking_requests/new").to route_to("booking_requests#new")
    end

    it "routes to #show" do
      expect(get: "/booking_requests/1").to route_to("booking_requests#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/booking_requests/1/edit").to route_to("booking_requests#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/booking_requests").to route_to("booking_requests#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/booking_requests/1").to route_to("booking_requests#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/booking_requests/1").to route_to("booking_requests#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/booking_requests/1").to route_to("booking_requests#destroy", id: "1")
    end
  end
end
