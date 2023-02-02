# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookingRequestsController, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: '/booking_requests/new').to route_to('booking_requests#new')
    end

    it 'routes to #show' do
      expect(get: '/booking_requests/1').to route_to('booking_requests#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/booking_requests').to route_to('booking_requests#create')
    end
  end
end
