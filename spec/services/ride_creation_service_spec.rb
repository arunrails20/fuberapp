# frozen_string_literal: true

require 'rails_helper'

describe RideCreationService do
  before :all do
    prepare_test_data
  end

  context 'with valid params and cab is available' do
    let(:params) do
      { vehicle_num: 'KA 10 2010', name: 'arun', mobile_number: 9_911_224_455,
        source: { "latitude": 19, "longitude": 8 },
        destination: { "latitude": 91, "longitude": 8 } }
    end

    let(:service) { RideCreationService.new(params) }

    it 'Should create ride' do
      expect(service.process).to eq(true)
      expect(service.errors.empty?).to eq(true)
      expect(service.ride.present?).to eq(true)
    end
  end

  context '#create_customer' do
    it 'Should create Customer record for valid params' do
      params = { vehicle_num: 'KA 10 2010', name: 'arun', mobile_number: 9_911_224_455,
                 source: { "latitude": 19, "longitude": 8 },
                 destination: { "latitude": 91, "longitude": 8 } }
      service = RideCreationService.new(params)
      customer = service.send('create_customer')
      # Above case new customer record has added, so thats the reason
      # total length is 2, Refactor this testcase
      expect(customer.mobile_number).to eq(params[:mobile_number])
      expect(Customer.all_customers.length).to eq(2)
      expect(service.errors.empty?).to eq(true)
    end

    it 'Should not create Customer record for invalid params' do
      params = { vehicle_num: 'KA 10 2010', name: 'arun', mobile_number: 'test',
                 source: { "latitude": 19, "longitude": 8 },
                 destination: { "latitude": 91, "longitude": 8 } }
      service = RideCreationService.new(params)
      customer = service.send('create_customer')
      expect(Customer.all_customers.length).to eq(2)
      expect(service.errors.empty?).to eq(false)
    end
  end

  context '#create_ride' do
    it 'Should create ride record for valid params' do
      params = { vehicle_num: 'KA 10 2010', name: 'arun', mobile_number: 9_911_224_455,
                 source: { "latitude": 19, "longitude": 8 },
                 destination: { "latitude": 91, "longitude": 8 } }
      service = RideCreationService.new(params)
      customer = service.send('create_customer')
      service.send('create_ride', customer.id)
      expect(Ride.all.length).to eq(2)
    end

    it 'Should not create ride record for invalid params' do
      params = { vehicle_num: 'KA 10 2010', name: 'arun', mobile_number: 9_911_224_455,
                 source: { "latitude": 8, "longitude": 8 },
                 destination: { "latitude": 'test', "longitude": 8 } }
      service = RideCreationService.new(params)
      customer = service.send('create_customer')
      service.send('create_ride', customer.id)

      expect(Ride.all.length).to eq(2)
      expect(service.errors.empty?).to eq(false)
    end
  end
end
