if Rails.env.test?
  Geocoder.configure(lookup: :test)
  Geocoder::Lookup::Test.add_stub(
      '東京タワー', [{
        'coordinates'  => [40.7143528, -74.0059731]
  }]
  )
  Geocoder::Lookup::Test.add_stub(
      '', []
  )
else
  Geocoder.configure(
    lookup: :google,
    api_key: ENV['GEOCODING_API_KEY']
  )
end  