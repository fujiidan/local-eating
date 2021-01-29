require 'rails_helper'

RSpec.describe 'Favorites', type: :system do
  describe 'お気に入り機能' do
    before do
      @community = FactoryBot.create(:community)
    end

    it 'お気に入りボタンをクリックするとお気に入りできること' do
      sign_in(@community.user)
      visit community_messages_path(@community)
      find('.favorite-link').click
      sleep(1)
      expect(Favorite.count).to eq 1
      expect(page).to have_css('.unfavorite-btn')
    end

    it 'お気に入り済みのボタンをクリックするとお気に入りを解除できること' do
      FactoryBot.create(:favorite, user_id: @community.user_id, community_id: @community.id)
      sign_in(@community.user)
      visit community_messages_path(@community)
      find('.favorite-link').click
      sleep(1)
      expect(Favorite.count).to eq 0
      expect(page).to have_css('.favorite-btn')
    end

    it 'ログイン状態のユーザーのみいねボタンが表示されること' do
      sign_in(@community.user)
      visit community_messages_path(@community)
      expect(page).to have_css('.favorite-link')
    end

    it 'ログイン済みでないユーザーにはお気に入りボタンが表示されないこと' do
      visit community_messages_path(@community)
      expect(page).to have_no_css('.favorite-link')
    end
  end

  describe 'お気に入り削除' do
    before do
      @profile = FactoryBot.create(:profile)
      @community = FactoryBot.create(:community, user_id: @profile.user_id)
    end

    it 'ユーザーアカウントが削除されるとユーザーに紐づくお気に入りも削除されること' do
      FactoryBot.create_list(:favorite, 3, user_id: @profile.user_id)
      sign_in(@profile.user)
      visit user_path(@profile.user)
      expect { click_on('アカウント削除') }.to change { @profile.user.favorites.count }.by(-3)
    end

    it 'コミュニティが削除されるとそれに紐づくお気に入りも削除されること' do
      FactoryBot.create_list(:favorite, 3, community_id: @community.id)
      sign_in(@profile.user)
      visit communities_path
      expect { click_on('削除する', match: :first) }.to change { @community.favorites.count }.by(-3)
    end
  end
end
