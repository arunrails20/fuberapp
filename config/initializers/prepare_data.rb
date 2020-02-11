cabs = [{color: "white", is_available: true, geo_location: GeoLocation.new(2,3), pricing: 34},
        {color: "red", is_available: true, geo_location: GeoLocation.new(9,3), pricing: 24},
        {color: "blue", is_available: true, geo_location: GeoLocation.new(20,3), pricing: 14},
        {color: "pink", is_available: true, geo_location: GeoLocation.new(8,3), pricing: 94}]

cabs.each do |cab|
  Cab.create(Cab.new(cab))
end