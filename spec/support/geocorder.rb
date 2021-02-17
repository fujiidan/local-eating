# geocordermockメモ
# module CreateStoreSupport
#   def geocorder

#     Geocoder.configure(lookup: :test)
#     Geocoder::Lookup::Test.add_stub(
#         '東京', [{
#         'geometry' => { 'location' => { 'lat' => 35.7090259, 'lng' => 139.7319925 } }
#     }]
#     )
#     Geocoder::Lookup::Test.add_stub(
#         'ダメなキーワード', []
#     )
#       end
# end