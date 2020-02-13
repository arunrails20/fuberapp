# frozen_string_literal: true

require 'rails_helper'

describe RideStartService do
  before :all do
    prepare_test_data
  end

  context 'Valid Ride' do
    let(:params) do
      { vehicle_num: 'KA 10 2010', name: 'arun', mobile_number: 9_911_224_455,
        source: { "latitude": 19, "longitude": 8 },
        destination: { "latitude": 91, "longitude": 8 } }
    end

    it 'Should start the ride successfully' do
      service = RideCreationService.new(params)
      service.process
      start_service = RideStartService.new(id: service.ride.id)

      expect(start_service.process).to eq(true)
      expect(start_service.errors.empty?).to eq(true)
      expect(service.ride.status).to eq(Ride::STATES[:inprogress])
      expect(service.ride.start_date.present?).to eq(true)
      expect(service.ride.booked_cab.status).to eq(Cab::STATES[:inprogress])
    end
  end

  context 'Invalid Ride' do
    let(:params) do
      { vehicle_num: 'KA 10 2010', name: 'arun', mobile_number: 9_911_224_455,
        source: { "latitude": 19, "longitude": 8 },
        destination: { "latitude": 91, "longitude": 8 } }
    end

    it 'Should not start the ride' do
      service = RideCreationService.new(params)
      service.process
      service.ride.status = Ride::STATES[:completed]
      start_service = RideStartService.new(id: service.ride.id)
      expect(start_service.process).to eq(false)
      expect(start_service.errors.empty?).to eq(false)
      expect(service.ride.status).to eq(Ride::STATES[:completed])
    end

    it 'Should not start the ride' do
      start_service = RideStartService.new(id: 23)
      expect(start_service.process).to eq(false)
      expect(start_service.errors).to eq([I18n.t('ride.not_found')])
    end
  end
end
