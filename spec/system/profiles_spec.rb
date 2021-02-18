require 'rails_helper'

RSpec.describe 'Profiles', type: :system do
  describe 'プロフィール編集機能' do
    before do
      @profile = FactoryBot.create(:profile)
    end

    context 'プロフィール編集できるとき' do
      it 'ログイン状態のユーザーのみがプロフィール情報編集ページに遷移できること' do
        sign_in(@profile.user)
        visit edit_user_profile_path(@profile.user, @profile)
        expect(current_path).to eq edit_user_profile_path(@profile.user, @profile)
      end

      it '必要な情報を適切に入力すると、プロフィール情報をを編集できること' do
        sign_in(@profile.user)
        visit user_path(@profile.user)
        click_on('プロフィール情報編集')
        expect(current_path).to eq edit_user_profile_path(@profile.user, @profile)
        fill_in 'address', with: '東京タワー'
        fill_in 'age', with: '100'
        find('#sex-id').find("option[value='2']").select_option
        click_on('編集する')
        expect(current_path).to eq user_path(@profile.user)
        expect(page).to have_content('テスト住所')
        expect(page).to have_content('100')
        expect(page).to have_content('女性')
      end
    end

    context 'プロフィール編集できないとき' do
      it '編集に失敗するとプロフィール編集ページに戻ってくること' do
        sign_in(@profile.user)
        visit edit_user_profile_path(@profile.user, @profile)
        fill_in 'address', with: ''
        click_on('編集する')
        expect(current_path).to eq user_profile_path(@profile.user, @profile)
      end

      it 'ログイン状態でも本人以外のユーザーがURLを直接入力してプロフィール情報編集ページに遷移しようとするとトップページに戻されること' do
        another_user = FactoryBot.create(:profile)
        sign_in(another_user.user)
        visit edit_user_profile_path(@profile.user, @profile)
        expect(current_path).to eq root_path
      end

      it '未ログインのユーザーがURLを直接入力してプロフィール情報編集ページに遷移しようとするとログイン画面に戻されること' do
        visit edit_user_profile_path(@profile.user, @profile)
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe 'プロフィール削除機能' do
    before do
      @profile = FactoryBot.create(:profile)
    end

    it 'ユーザーアカウントが削除されるとそれに紐づくプロフィール情報も削除されること' do
      sign_in(@profile.user)
      visit user_path(@profile.user)
      expect { click_on('アカウント削除') }.to change { Profile.count }.by(-1)
      expect(current_path).to eq root_path
    end
  end
end
