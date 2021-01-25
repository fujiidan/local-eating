require 'rails_helper'

RSpec.describe 'Users', type: :system do
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

    it 'ログイン状態では、ヘッダーにユーザーのマイページのリンク/ログアウトボタンが表示されること' do
      sign_in(@user)
      expect(page).to have_content("#{@user.nickname}さんのマイページ")
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

  describe 'ユーザー詳細機能（マイページ)' do
    before do
      @user = FactoryBot.create(:user)
      @profile = FactoryBot.create(:profile, user_id: @user.id)
    end

    it 'ユーザー詳細ページにはユーザー情報とプロフィール情報が表示されること' do
      visit root_path
      sign_in(@user)
      click_on("#{@user.nickname}さんのマイページ")
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content(@user.email)
      expect(page).to have_content(@profile.address)
      expect(page).to have_content(@profile.sex.name)
      expect(page).to have_content(@profile.age)
    end

    it 'ログイン状態のユーザーのみがマイページに遷移できること' do
      visit root_path
      sign_in(@user)
      click_on("#{@user.nickname}さんのマイページ")
      expect(current_path).to eq user_path(@user)
    end

    it 'ログイン状態でも本人以外のユーザーがURLを直接入力してマイページに遷移しようとするとトップページに戻されること' do
      another_user = FactoryBot.create(:user)
      visit root_path
      sign_in(another_user)
      visit user_path(@user)
      expect(current_path).to eq root_path
    end

    it '未ログインのユーザーがURLを直接入力してマイページに遷移しようとするとログイン画面に戻されること' do
      visit root_path
      visit user_path(@user)
      expect(current_path).to eq new_user_session_path
    end
  end

  describe 'ユーザー編集機能' do
    before do
      @user = FactoryBot.create(:user)
      @profile = FactoryBot.create(:profile, user_id: @user.id)
    end

    it '必要な情報を適切に入力すると、ユーザー情報をを編集できること' do
      visit root_path
      sign_in(@user)
      click_on("#{@user.nickname}さんのマイページ")
      click_on('ユーザー情報編集')
      expect(current_path).to eq edit_user_path(@user)
      fill_in 'nickname', with: 'テスト編集'
      fill_in 'email', with: 'test@test'
      click_on('編集する')
      expect(current_path).to eq user_path(@user)
      expect(page).to have_content('テスト編集')
      expect(page).to have_content('test@test')
    end

    it 'ログイン状態のユーザーのみがユーザー情報編集ページに遷移できること' do
      visit root_path
      sign_in(@user)
      visit edit_user_path(@user)
      expect(current_path).to eq edit_user_path(@user)
    end

    it 'ログイン状態でも本人以外のユーザーがURLを直接入力してユーザー情報編集ページに遷移しようとするとトップページに戻されること' do
      another_user = FactoryBot.create(:user)
      visit root_path
      sign_in(another_user)
      visit edit_user_path(@user)
      expect(current_path).to eq root_path
    end

    it '未ログインのユーザーがURLを直接入力してユーザー情報編集ページに遷移しようとするとログイン画面に戻されること' do
      visit root_path
      visit edit_user_path(@user)
      expect(current_path).to eq new_user_session_path
    end
  end

  describe 'ユーザー削除機能' do
    before do
      @user = FactoryBot.create(:user)
      @profile = FactoryBot.create(:profile, user_id: @user.id)
    end

    it 'ユーザー本人のみがアカウントを削除できること' do
      visit root_path
      sign_in(@user)
      click_on("#{@user.nickname}さんのマイページ")
      expect { click_on('アカウント削除') }.to change { User.count }.by(-1)
      expect(current_path).to eq root_path
    end
  end
end
