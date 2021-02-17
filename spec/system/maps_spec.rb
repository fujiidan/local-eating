# require 'rails_helper'
# # テストコード上でAPIを使用してしまっているので訂正する、動作自体はOK
# # docker環境でjs動かない為一旦コメントアウト

# RSpec.describe 'Maps', type: :system do
#   describe 'googlemap表示機能' do
#     before do
#       @profile = FactoryBot.create(:profile, address: '東京タワー')
#       @store = FactoryBot.create(:store, address: 'スカイツリー')
#     end

#     it 'マイページに遷移するとユーザーの登録した住所がマップ上にアイコンで表示されていること' do
#       sign_in(@profile.user)
#       visit user_path(@profile.user)
#       expect(page).to have_selector('.map-info')
#       expect(page).to have_content('東京タワー')
#     end

#     it 'お気に入りページに遷移するとユーザーの登録した住所がマップ上にアイコンで表示されていること' do
#       sign_in(@profile.user)
#       visit favorite_user_path(@profile.user)
#       expect(page).to have_selector('.map-info')
#       expect(page).to have_content('東京タワー')
#     end

#     it '店舗詳細ページに遷移すると店舗登録した店名と住所マップ上にアイコンで表示されていること' do
#       sign_in(@profile.user)
#       visit store_path(@store)
#       expect(page).to have_selector('.map-info')
#       expect(page).to have_content('スカイツリー')
#     end
#   end

#   describe 'googlemap店舗一覧表示機能' do
#     before do
#       @profile = FactoryBot.create(:profile, address: '東京タワー')
#       @store = FactoryBot.create(:store, address: '東京タワー', user_id: @profile.user_id)
#       @like = FactoryBot.create(:like, user_id: @profile.user_id, store_id: @store.id)
#     end

#     it 'トップページには店舗登録したアイコンが表示されていること' do
#       visit root_path
#       expect(page).to have_selector("img[src$='transparent.png']")
#     end

#     it 'マイページには店舗登録した情報が表示されていること' do
#       sign_in(@profile.user)
#       visit user_path(@profile.user)
#       sleep 1
#       expect(all("img[src$='transparent.png']").count).to eq 2
#     end

#     it 'お気に入りページにはお気に入りした店舗登録した情報が表示されていること' do
#       sign_in(@profile.user)
#       visit favorite_user_path(@profile.user)
#       sleep 1
#       expect(all("img[src$='transparent.png']").count).to eq 2
#     end
#   end

#   describe 'googlemap検索機能' do

#     context '地図検索できるとき' do

#       it 'トップページにて検索を行うと地図上に検索結果が表示されたピンがたつこと' do, js: true 
#         visit root_path
#         fill_in 'address', with: '東京タワー'
#         click_on('地図検索')
#         expect(page).to have_selector('.map-info')
#         expect(page).to have_content('検索結果')
#         expect(page).to have_content('東京タワー')
#       end
#     end

#     context '地図検索できないとき' do

#       it 'トップページにて検索に失敗するとそのページに留まること' do
#         visit root_path
#         click_on('地図検索')
#         expect(current_path).to eq root_path
#       end
#     end
#   end

#   describe 'アイコン表示機能' do
#     before do
#       @store = FactoryBot.create(:store, address: '東京タワー')
#     end

#     it '地図情報のアイコンをクリックすると、店名、住所、詳細ページへのリンクが表示されること' do
#       visit root_path
#       find('map#gmimap0 area', visible: false).click
#       expect(page).to have_selector('.map-store-info')
#       expect(page).to have_content(@store.name)
#       expect(page).to have_content(@store.address)
#       expect(page).to have_content(@store.name)
#       expect(page).to have_content('店舗詳細ページへ')
#     end
#   end
# end
