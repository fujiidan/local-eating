require 'rails_helper'

RSpec.describe 'Communities', type: :system do
  describe 'コミュニティ一覧ページ' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'ログイン状態のユーザーのみコミュニティ作成フォームが表示されること' do
      sign_in(@user)
      visit communities_path
      expect(page).to have_selector('#community-input')
    end

    it 'ログインしているコミュニティ作成者本人のみ編集する・削除するのボタンが表示されること' do
      FactoryBot.create(:community, user_id: @user.id)
      sign_in(@user)
      visit communities_path
      expect(page).to have_content('編集する')
      expect(page).to have_content('削除する')
    end

    it '未ログインのユーザーにはコミュニティ作成フォームが表示されないこと' do
      visit communities_path
      expect(page).to have_no_selector('#community-input')
    end

    it 'ログイン済みであっても。コミュニティ作成者本人以外は編集する・削除するのボタンが表示されないこと' do
      FactoryBot.create(:community, user_id: @user.id)
      another_user = FactoryBot.create(:user)
      sign_in(another_user)
      visit communities_path
      expect(page).to have_no_content('編集する')
      expect(page).to have_no_content('削除する')
    end

    it '未ログインのユーザーであっても。コミュニティ作成者本人以外は編集する・削除するのボタンが表示されないこと' do
      FactoryBot.create(:community, user_id: @user.id)
      visit communities_path
      expect(page).to have_no_content('編集する')
      expect(page).to have_no_content('削除する')
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

  describe 'コミュニティ編集機能' do
    before do
      @user = FactoryBot.create(:user)
      @community = FactoryBot.create(:community)
    end

    it '必要な情報を適切に入力すると、コミュニティ情報をを編集できること' do
      sign_in(@community.user)
      visit edit_community_path(@community)
      fill_in 'name', with: 'テストname'
      click_on('編集する')
      expect(current_path).to eq community_messages_path(@community)
      expect(page).to have_content('テストname')
    end

    it 'ログイン状態の出品者だけがコミュニティ編集ページに遷移できること' do
      sign_in(@community.user)
      visit edit_community_path(@community)
      expect(current_path).to eq edit_community_path(@community)
    end

    it 'ログイン状態のコミュニティ作成者以外のユーザーは、URLを直接入力してコミュニティ編集ページへ遷移しようとすると、トップページに遷移すること' do
      sign_in(@user)
      visit edit_community_path(@community)
      expect(current_path).to eq root_path
    end

    it 'ログアウト状態のユーザーは、URLを直接入力してコミュニティ編集ページへ遷移しようとすると、ログインページに遷移すること' do
      visit edit_community_path(@community)
      expect(current_path).to eq new_user_session_path
    end
  end

  describe 'コミュニティ削除' do
    before do
      @community = FactoryBot.create(:community)
      @profile = FactoryBot.create(:profile, user_id: @community.user_id)
      FactoryBot.create_list(:community, 3, user_id: @community.user_id)
    end

    it 'コミュニティ作成者だけがコミュニティを削除できること' do
      sign_in(@community.user)
      visit communities_path
      expect { click_on('削除する', match: :first) }.to change { Community.count }.by(-1)
      expect(current_path).to eq user_path(@community.user)
    end

    it 'ユーザーアカウントが削除されるとそれに紐づくコミュニティも削除されること' do
      sign_in(@community.user)
      click_on("#{@community.user.nickname}さんのマイページ")
      expect { click_on('アカウント削除') }.to change { Community.count }.by(-4)
      expect(current_path).to eq root_path
    end
  end
end
