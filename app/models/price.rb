class Price < ActiveHash::Base
  self.data = [
    { id:1, name: '¥0~¥1,000'},
    { id:2, name: '¥1,000~¥2,000'},
    { id:3, name: '¥2,000~¥3,000'},
    { id:4, name: '¥3,000~¥4,000'},
    { id:5, name: '¥4,000~¥5,000'},
    { id:6, name: '¥5,000~¥6,000'},
    { id:7, name: '¥7,000~¥8,000'},
    { id:8, name: '¥8,000~¥9,000'},
    { id:9, name: '¥9,000~¥10,000'},
    { id:10, name: '¥10,000~'}
  ]
end  