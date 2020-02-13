# frozen_string_literal: true

cabs = [{ color: 'white',
          geo_location: GeoLocation.new(2, 3),
          vehicle_num: 'KA 10 2010' },
        { color: 'red',
          geo_location: GeoLocation.new(9, 3),
          vehicle_num: 'KA 10 2020' },
        { color: 'blue',
          geo_location: GeoLocation.new(20, 3),
          vehicle_num: 'KA 10 2030' },
        { color: 'pink',
          geo_location: GeoLocation.new(8, 3),
          vehicle_num: 'KA 10 2040' }]

cabs.each do |cab|
  Cab.create(Cab.new(cab))
end
