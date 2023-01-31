require 'rails_helper'

RSpec.describe BookingRequest, type: :model do
  describe 'attributes' do
    it { expect(build(:booking_request)).to be_valid }

    describe 'name' do
      it { should validate_presence_of(:name) }
    end

    describe 'phone' do
      it { should validate_presence_of(:phone) }
      it { should allow_value('01 99 00 12 34').for(:phone)}
      it { should allow_value('0199001234').for(:phone)}
      it { should allow_value('01-99-00-12-34').for(:phone)}
      it { should_not allow_value('abc').for(:phone)}
      it { should_not allow_value('123').for(:phone)}

      it 'should be normalized when valid' do
        request = build(:booking_request, phone: '01 99 00 12 34')

        expect(request).to be_valid
        expect(request.phone).to  eq('+33199001234')
      end
    end

    describe 'email' do
      it { should validate_presence_of(:email) }
      it { should allow_value('john@example.com').for('email') }
      it { should allow_value('john.doe+1@example.com').for('email') }
      it { should allow_value('JDOE@EXAMPLE.CO').for('email') }
      it { should allow_value('john@example').for('email') }
      it { should_not allow_value('john.example.com').for('email') }
    end

    describe 'biography' do
      it 'does not accept biography with less than 5 words' do
        should allow_value('I am a good enough description').for('biography')
        should_not allow_value('Nothing to say !').for('biography')
      end
    end
  end

  describe 'state' do
    it { should have_state(:unconfirmed) }
    it { should transition_from(:unconfirmed).to(:confirmed).on_event(:confirm) }
  end

  describe 'events' do
    context 'when confirmed' do
      let(:request) { create(:booking_request, :unconfirmed) }

      it 'set confirmed_at' do
        freeze_time do
          expect {request.confirm!}.to change {request.confirmed_at}.to(Time.zone.now)
        end
      end
    end
  end

  describe 'scopes' do
    describe '#confirmed' do
      let!(:next_confirmed) { create(:booking_request, :confirmed, confirmed_at: 2.minutes.ago, created_at: 10.minutes.ago) }
      let!(:first_confirmed) { create(:booking_request, :confirmed, confirmed_at: 10.minutes.ago) }
      let!(:unconfirmed_request) { create(:booking_request, :unconfirmed) }

      it 'returns confirmed request sorted by confirmation date' do
        confirmed_requests = BookingRequest.confirmed.to_a

        expect(confirmed_requests.first).to eq first_confirmed
        expect(confirmed_requests.last).to eq next_confirmed
        expect(confirmed_requests).to_not include(unconfirmed_request)
      end
    end
  end
end
