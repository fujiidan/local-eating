if Rails.env.test?
  Geocoder.configure(lookup: :test)
  Geocoder::Lookup::Test.add_stub(
      '東京タワー', [{
        'coordinates'  => [35.6586, 139.745]
  }]
  )
  Geocoder::Lookup::Test.add_stub(
    'スカイツリー', [{
      'coordinates'  => [35.7101, 139.811]
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