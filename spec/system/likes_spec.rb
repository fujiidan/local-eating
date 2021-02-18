require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  describe 'いいね機能' do
    before do
      @store = FactoryBot.create(:store)
      @profile = FactoryBot.create(:profile, user_id: @store.user_id)
    end

    context 'いいねできるとき' do
      it 'ログイン状態のユーザーのみいねボタンが表示されること' do
        sign_in(@store.user)
        visit store_path(@store)
        expect(page).to have_css('.like-link')
      end
      # docker環境でjs動かない為一旦コメントアウト
      it 'いいねボタンをクリックするといいねできること', js: true do
        sign_in(@store.user)
        visit store_path(@store)
        find('.like-link').click
        sleep(1)
        expect(Like.count).to eq 1
        expect(page).to have_css('.unlike-btn')
      end

      it 'いいね済みのボタンをクリックするといいねを解除できること', js: true  do 
        FactoryBot.create(:like, user_id: @store.user_id, store_id: @store.id)
        sign_in(@store.user)
        visit store_path(@store)
        find('.like-link').click
        sleep(1)
        expect(Like.count).to eq 0
        expect(page).to have_css('.like-btn')
      end
    end

    context 'いいねできないとき' do
      it 'ログイン済みでないユーザーにはいいねボタンが表示されないこと' do
        visit store_path(@store)
        expect(page).to have_no_css('.like-link')
      end
    end
  end

  describe 'いいね削除' do
    before do
      @profile = FactoryBot.create(:profile)
      @store = FactoryBot.create(:store, user_id: @profile.user_id)
    end

    it 'ユーザーアカウントが削除されるとユーザーに紐づくいいねも削除されること' do
      FactoryBot.create_list(:like, 3, user_id: @profile.user_id)
      sign_in(@profile.user)
      visit user_path(@profile.user)
      expect { click_on('アカウント削除') }.to change { @profile.user.likes.count }.by(-3)
    end

    it '店舗情報が削除されるとそれに紐づくいいねも削除されること' do
      FactoryBot.create_list(:like, 3, store_id: @store.id)
      sign_in(@profile.user)
      visit store_path(@store)
      expect { click_on('削除する') }.to change { @store.likes.count }.by(-3)
    end
  end
end
