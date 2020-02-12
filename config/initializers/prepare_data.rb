# frozen_string_literal: true

cabs = [{ color: 'white', is_available: true,
          geo_location: GeoLocation.new(2, 3),
          pricing: 34, vehicle_num: 'KA 10 2010' },
        { color: 'red', is_available: true,
          geo_location: GeoLocation.new(9, 3),
          pricing: 24, vehicle_num: 'KA 10 2020' },
        { color: 'blue', is_available: true,
          geo_location: GeoLocation.new(20, 3),
          pricing: 14, vehicle_num: 'KA 10 2030' },
        { color: 'pink', is_available: true,
          geo_location: GeoLocation.new(8, 3),
          pricing: 94, vehicle_num: 'KA 10 2040' }]

cabs.each do |cab|
  Cab.create(Cab.new(cab))
end
