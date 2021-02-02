require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'ユーザー登録・ログイン認証' do
    before do
      @user = FactoryBot.build(:user)
      @profile = FactoryBot.build(:profile)
    end

    context '新規登録、ログインできるとき' do

      it '新規登録ができるとトップページに遷移すること' do
        sign_up(@user, @profile)
      end

      it 'ログインできるとトップページに遷移すること' do
        @profile.save
        sign_in(@profile.user)
      end
    end

    context '新規登録、ログインできないとき' do

      it '新規登録に失敗すると再び新規登録画面に戻ってくること' do
        visit new_user_registration_path
        click_on('プロフィール情報入力へ')
        expect(current_path).to eq user_registration_path
      end

      it 'プロフィール情報の登録に失敗するとプロフィール情報登録画面に戻ってくること' do
        visit new_user_registration_path
        fill_in 'nickname', with: @user.nickname
        fill_in 'email', with: @user.email
        fill_in 'password', with: @user.password
        fill_in 'password-confirmation', with: @user.password
        click_on('プロフィール情報入力へ')
        expect { click_on('新規登録') }.to change { User.count }.by(0).and change { Profile.count }.by(0)
        expect(current_path).to eq profiles_path
      end      

      it 'ログインに失敗するとログイン画面に戻ってくること' do
        visit new_user_session_path
        click_on('ログイン')
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe 'トップページ' do
    before do
      @profile = FactoryBot.create(:profile)
    end

    context 'ログイン時' do

      it 'ログイン状態では、ヘッダーにユーザーのマイページのリンク/お気に入りリスト/ログアウトボタンが表示されること' do
        sign_in(@profile.user)
        expect(page).to have_content("#{@profile.user.nickname}さんのマイページ")
        expect(page).to have_content("お気に入りリスト")
        expect(page).to have_content('ログアウト')
      end

      it 'ヘッダーのログアウトボタンをクリックすることで、ログアウトができること' do
        sign_in(@profile.user)
        click_on('ログアウト')
        expect(current_path).to eq root_path
        expect(page).to have_content('ログイン')
      end
    end  

    context 'ログアウト時' do
      it 'ログアウト状態では、ヘッダーに新規登録/ログインボタン/ゲストさんが表示されること' do
        visit root_path
        expect(page).to have_content('新規登録')
        expect(page).to have_content('ログイン')
        expect(page).to have_content('ゲストさん')
      end
    end  
  end

  describe 'ユーザー詳細機能（マイページ)' do
    before do
      @profile = FactoryBot.create(:profile)
    end
    
    context 'マイページに遷移できるとき' do

      it 'ログイン状態のユーザーのみがマイページに遷移できること' do
        sign_in(@profile.user)
        click_on("#{@profile.user.nickname}さんのマイページ")
        expect(current_path).to eq user_path(@profile.user)
      end

      it 'ユーザー詳細ページにはユーザー情報とプロフィール情報が表示されること' do
        sign_in(@profile.user)
        visit user_path(@profile.user)
        expect(page).to have_content(@profile.user.nickname)
        expect(page).to have_content(@profile.user.email)
        expect(page).to have_content(@profile.address)
        expect(page).to have_content(@profile.sex.name)
        expect(page).to have_content(@profile.age)
      end
    end  

    context 'マイページに遷移できないとき' do

      it 'ログイン状態でも本人以外のユーザーがURLを直接入力してマイページに遷移しようとするとトップページに戻されること' do
        another_user = FactoryBot.create(:profile)
        sign_in(another_user.user)
        visit user_path(@profile.user)
        expect(current_path).to eq root_path
      end

      it '未ログインのユーザーがURLを直接入力してマイページに遷移しようとするとログイン画面に戻されること' do
        visit root_path
        visit user_path(@profile.user)
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe 'ユーザーお気に入りページ' do
    before do
      @profile = FactoryBot.create(:profile)
      @like = FactoryBot.create(:like, user_id: @profile.user_id)
      @favorite = FactoryBot.create(:favorite, user_id: @profile.user_id)
    end

    context 'お気に入りページに遷移できるとき' do

      it 'ログイン状態のユーザーのみがお気に入りページに遷移できること' do
        sign_in(@profile.user)
        click_on('お気に入りリスト')
        expect(current_path).to eq favorite_user_path(@profile.user)
      end

      it 'お気に入りページにはいいねとお気に入りをした情報が表示されること' do
        sign_in(@profile.user)
        visit favorite_user_path(@profile.user)
        expect(page).to have_content(@like.store.name)
        expect(page).to have_content(@favorite.community.name)
      end
    end

    context 'お気に入りページに遷移できないとき' do

      it 'ログイン状態でも本人以外のユーザーがURLを直接入力してお気に入りページに遷移しようとするとトップページに戻されること' do
        another_user = FactoryBot.create(:profile)
        sign_in(another_user.user)
        favorite_user_path(@profile.user)
        expect(current_path).to eq root_path
      end

      it '未ログインのユーザーがURLを直接入力してお気に入りページに遷移しようとするとログイン画面に戻されること' do
        visit favorite_user_path(@profile.user)
        expect(current_path).to eq new_user_session_path
      end
    end  
  end

  describe 'ユーザー編集機能' do
    before do
      @profile = FactoryBot.create(:profile)
    end

    context 'ユーザー編集できるとき' do

      it 'ログイン状態のユーザーのみがユーザー情報編集ページに遷移できること' do
        sign_in(@profile.user)
        visit user_path(@profile.user)
        click_on('ユーザー情報編集')
        expect(current_path).to eq edit_user_path(@profile.user)
      end

      it '必要な情報を適切に入力すると、ユーザー情報をを編集できること' do
        sign_in(@profile.user)
        visit edit_user_path(@profile.user)
        fill_in 'nickname', with: 'テスト編集'
        fill_in 'email', with: 'test@test'
        click_on('編集する')
        expect(current_path).to eq user_path(@profile.user)
        expect(page).to have_content('テスト編集')
        expect(page).to have_content('test@test')
      end
    end  

    context 'ユーザー編集できないとき' do

      it '編集に失敗するとユーザー編集ページに戻ってくること' do
        sign_in(@profile.user)
        visit edit_user_path(@profile.user)
        fill_in 'nickname', with: ""
        click_on('編集する')
        expect(current_path).to eq user_path(@profile.user)
      end  


      it 'ログイン状態でも本人以外のユーザーがURLを直接入力してユーザー情報編集ページに遷移しようとするとトップページに戻されること' do
        another_user = FactoryBot.create(:profile)
        sign_in(another_user.user)
        visit edit_user_path(@profile.user)
        expect(current_path).to eq root_path
      end

      it '未ログインのユーザーがURLを直接入力してユーザー情報編集ページに遷移しようとするとログイン画面に戻されること' do
        visit edit_user_path(@profile.user)
        expect(current_path).to eq new_user_session_path
      end
    end  
  end

  describe 'ユーザー削除機能' do
    before do
      @profile = FactoryBot.create(:profile)
    end

    it 'ユーザー本人のみがアカウントを削除できること' do
      sign_in(@profile.user)
      visit user_path(@profile.user)
      expect { click_on('アカウント削除') }.to change { User.count }.by(-1)
      expect(current_path).to eq root_path
    end
  end
end
