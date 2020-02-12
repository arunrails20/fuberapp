# frozen_string_literal: true

require 'rails_helper'
describe CabSearchService do
  before :all do
    prepare_test_data
  end

  context 'with valid params and cab is available' do
    let(:service) { CabSearchService.new(3, 4) }

    it '#process' do
      expect(service.process).to eq(true)
      expect(service.available_cab.present?).to eq(true)
      expect(service.errors.empty?).to eq(true)
      # TODOs need cover shortest distance cab
      # expect(service.shorest_distance).to eq(true)
    end
  end

  context 'with invalid latitude and longitude' do
    let(:service) { CabSearchService.new(3, nil) }
    it '#process' do
      expect(service.process).to eq(false)
      expect(service.available_cab.present?).to eq(false)
      expect(service.errors.empty?).to eq(false)
    end
  end

  context '#convert_to_float' do
    let(:service) { CabSearchService.new(3, 4) }
    let(:invalid_service) { CabSearchService.new('test', nil) }

    it 'Should change the value to Float' do
      service.send('convert_to_float')
      expect(service.latitude.instance_of?(Float)).to eq(true)
      expect(service.longitude.instance_of?(Float)).to eq(true)
    end

    it 'Should not change the value to Float' do
      invalid_service.send('convert_to_float')
      expect(invalid_service.latitude.instance_of?(Float)).to eq(false)
      expect(invalid_service.longitude.instance_of?(Float)).to eq(false)
    end
  end

  context '#calculate_distance' do
    let(:service) { CabSearchService.new(3, 4) }

    it 'Should return the distance value' do
      cab = Cab.new(color: 'white', is_available: true, geo_location: GeoLocation.new(7, 7), pricing: 34)
      service.send('convert_to_float')
      expect(service.send('calculate_distance', cab.geo_location)).to eq(5.0)
    end
  end

  # TODOs have to cover this case
  context 'with valid params and cab is not available' do
  end
end
