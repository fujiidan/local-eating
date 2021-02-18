if Rails.env.test?
  Geocoder.configure(lookup: :test)
  Geocoder::Lookup::Test.add_stub(
      '東京タワー', [{
      'geometry' => { 'location' => { 'lat' => 35.7090259, 'lng' => 139.7319925 } }
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