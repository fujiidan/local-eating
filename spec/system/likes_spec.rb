require 'rails_helper'

RSpec.describe "Likes", type: :system do

  describe 'いいね機能' do
    before do
      @store = FactoryBot.create(:store)
    end
    
    it 'いいねボタンをクリックするといいねできること' do
      sign_in(@store.user)
      visit store_path(@store)
      find('.like-link').click
      sleep(1)
      expect(Like.count).to eq 1
      expect(page).to have_css (".unlike-btn")
    end

    it 'いいね済みのボタンをクリックするといいねを削除できること' do
      FactoryBot.create(:like, user_id: @store.user_id, store_id: @store.id)
      sign_in(@store.user)
      visit store_path(@store)
      find('.like-link').click
      sleep(1)
      expect(Like.count).to eq 0
      expect(page).to have_css (".like-btn")
    end

    it 'ログイン状態のユーザーのみいねボタンが表示されること' do
      sign_in(@store.user)
      visit store_path(@store)
      expect(page).to have_css (".like-link")

    end  

    it 'ログイン済みでないユーザーにはいいねボタンが表示されないこと' do
      visit store_path(@store)
      expect(page).to have_no_css (".like-link")
    end  
  end  
end
