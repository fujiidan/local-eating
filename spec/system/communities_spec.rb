require 'rails_helper'

RSpec.describe "Communities", type: :system do

  describe 'コミュニティ一覧ページ' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'ログイン状態のユーザーのみコミュニティ作成フォームが表示されること' do
      sign_in(@user)
      visit communities_path
      expect(page).to have_selector("#community-input")
    end

    it 'ログインしているコミュニティ作成者本人のみ編集する・削除するのボタンが表示されること' do
      FactoryBot.create(:community, user_id: @user.id)
      sign_in(@user)
      visit communities_path
      expect(page).to have_content("編集する")
      expect(page).to have_content("削除する")
    end  

    it '未ログインのユーザーにはコミュニティ作成フォームが表示されないこと' do
      visit communities_path
      expect(page).to have_no_selector("#community-input")
    end

    it 'ログイン済みであっても。コミュニティ作成者本人以外は編集する・削除するのボタンが表示されないこと' do
      FactoryBot.create(:community, user_id: @user.id)
      another_user = FactoryBot.create(:user)
      sign_in(another_user)
      visit communities_path
      expect(page).to have_no_content("編集する")
      expect(page).to have_no_content("削除する")
    end

    it '未ログインのユーザーであっても。コミュニティ作成者本人以外は編集する・削除するのボタンが表示されないこと' do
      FactoryBot.create(:community, user_id: @user.id)
      visit communities_path
      expect(page).to have_no_content("編集する")
      expect(page).to have_no_content("削除する")
    end

  end

  describe 'コミュニティ作成' do
    before do
      @community = FactoryBot.build(:community)
      @user = FactoryBot.create(:user)
    end

    context 'コミュニテイ作成できるとき' do
      it 'コミュニテイ作成すると、ページ遷移無くコメントが表示される' do
        sign_in(@user)
        visit communities_path
        fill_in 'community-input', with: @community.name
        click_on('作成する')
        sleep 1
        expect(Community.count).to eq 1
        expect(current_path).to eq communities_path
        expect(page).to have_content(@community.name)
      end
    end

    context 'コミュニテイ作成できないとき' do
      it 'コミュニテイ作成に失敗すると、ページ遷移なくとどまる' do
        sign_in(@user)
        visit communities_path
        click_on('作成する')
        sleep 1
        expect(Community.count).to eq 0
        expect(current_path).to eq communities_path
      end
    end  
  end

  describe 'コミュニティ削除' do
    before do
      @user = FactoryBot.create(:user)
      @profile = FactoryBot.create(:profile, user_id: @user.id)
      FactoryBot.create_list(:community, 3, user_id: @user.id)
    end

    it 'ユーザーアカウントが削除されるとそれに紐づくコメント情報も削除されること' do
      sign_in(@user)
      click_on("#{@user.nickname}さんのマイページ")
      expect { click_on('アカウント削除') }.to change { Community.count }.by(-3)
      expect(current_path).to eq root_path
    end
  end
end
