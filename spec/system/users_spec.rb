require 'rails_helper'

RSpec.describe "Users", type: :system do

  describe 'ユーザー登録・ログイン認証' do
    before do
      @user = FactoryBot.build(:user)
      @profile = FactoryBot.build(:profile)
    end
    
    context '新規登録、ログインできるとき' do
      it '新規登録ができること' do
        sign_up(@user, @profile)
      end  

      it 'ログインできること' do
        @user.save
        sign_in(@user)
      end   
    end
    
    context '新規登録、ログインできないとき' do
      it '新規登録に失敗すると再び新規登録画面に戻ってくる' do
        visit new_user_registration_path
        click_on('プロフィール情報入力へ')
        expect(current_path).to eq user_registration_path
      end

      it 'ログインに失敗するとログイン画面に戻ってくる' do
        visit new_user_session_path
        click_on('ログイン')
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe 'トップページ' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'ログイン状態では、ヘッダーにユーザーのニックネーム/ログアウトボタンが表示されること' do
      sign_in(@user)
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('ログアウト')
    end
    
    it 'ログアウト状態では、ヘッダーに新規登録/ログインボタン/ゲストさんが表示されること' do
      visit root_path
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
      expect(page).to have_content('ゲストさん')
    end

    it 'ヘッダーの新規登録/ログインボタンをクリックすることで、各ページに遷移できること' do
      visit root_path
      click_on('新規登録')
      expect(current_path).to eq new_user_registration_path
      visit root_path
      click_on('ログイン')
      expect(current_path).to eq new_user_session_path
    end

    it 'ヘッダーのログアウトボタンをクリックすることで、ログアウトができること' do
      sign_in(@user)
      click_on('ログアウト')
      expect(current_path).to eq root_path
      expect(page).to have_content('ログイン')
    end
  end
end
