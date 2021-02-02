require 'rails_helper'

RSpec.describe 'Stores', type: :system do
  describe '店舗登録' do
    before do
      @store = FactoryBot.build(:store)
      @profile = FactoryBot.create(:profile)
    end

    context '店舗登録できるとき' do
      it 'ログイン状態のユーザーのみが店舗登録ページに遷移でき、登録完了すると店舗詳細ページに遷移する' do
        create_store(@profile.user, @store)
      end
    end

    context '店舗登録できないとき' do
      it 'ログインしていないユーザーは、店舗登録ページに遷移しようとすると、ログインページに遷移する' do
        visit root_path
        click_on('飲食店を追加する')
        expect(current_path).to eq new_user_session_path
      end

      it '店舗登録に失敗すると、商品登録ページに戻ってくる' do
        sign_in(@profile.user)
        click_on('飲食店を追加する')
        expect { click_on('店舗登録') }.to change { Store.count }.by(0)
        expect(current_path).to eq stores_path
      end
    end
  end

  describe '店舗詳細ページ' do
    before do
      @store = FactoryBot.create(:store)
      @profile = FactoryBot.create(:profile, user_id: @store.user_id)
    end

    it '商品出品時に登録した情報が見られるようになっていること' do
      visit store_path(@store)
      expect(page).to have_content(@store.name)
      expect(page).to have_content(@store.url)
      expect(page).to have_content(@store.genre.name)
      expect(page).to have_content(@store.price.name)
      expect(page).to have_content(@store.user.nickname)
      expect(page).to have_content(@store.info)
      expect(page).to have_selector("img[src$='test_image.png']")
    end

    it 'ログイン状態の出品者のみ、「編集・削除ボタン」が表示されること' do
      sign_in(@store.user)
      visit store_path(@store)
      expect(page).to have_content('編集する')
      expect(page).to have_content('削除する')
    end

    it 'ログイン状態のユーザーのみ、「コメントする」ボタンが表示されること' do
      sign_in(@store.user)
      visit store_path(@store)
      expect(page).to have_selector('.form-submit-btn')
    end

    it 'ログイン状態でも出品者でない場合、「編集・削除ボタン」が表示されないこと' do
      another_user = FactoryBot.create(:profile)
      sign_in(another_user.user)
      visit store_path(@store)
      expect(page).to have_no_content('編集する')
      expect(page).to have_no_content('削除する')
    end

    it '未ログイン状態のユーザーには、「コメントする」ボタンが表示されないこと' do
      visit store_path(@store)
      expect(page).to have_no_selector('.form-submit-btn')
    end
  end

  describe '店舗編集機能' do
    before do
      @store = FactoryBot.create(:store)
      @profile = FactoryBot.create(:profile, user_id: @store.user_id)
    end

    context '店舗情報編集できるとき' do
      it 'ログイン状態の出品者だけが店舗情報編集ページに遷移できること' do
        sign_in(@store.user)
        visit store_path(@store)
        click_on('編集する')
        expect(current_path).to eq edit_store_path(@store)
      end

      it '必要な情報を適切に入力すると、店舗情報をを編集できること' do
        sign_in(@store.user)
        visit edit_store_path(@store)
        fill_in 'name', with: 'テストname'
        click_on('編集する')
        expect(current_path).to eq store_path(@store)
        expect(page).to have_content('テストname')
      end
    end

    context '店舗情報編集できないとき' do
      it '店舗編集に失敗すると編集画面に戻ってくること' do
        sign_in(@store.user)
        visit edit_store_path(@store)
        fill_in 'name', with: ''
        click_on('編集する')
        expect(current_path).to eq store_path(@store)
      end

      it 'ログイン状態の店舗作成者以外のユーザーは、URLを直接入力して店舗情報編集ページへ遷移しようとすると、トップページに遷移すること' do
        another_user = FactoryBot.create(:profile)
        sign_in(another_user.user)
        visit edit_store_path(@store)
        expect(current_path).to eq root_path
      end

      it 'ログアウト状態のユーザーは、URLを直接入力して店舗情報編集ページへ遷移しようとすると、ログインページに遷移すること' do
        visit edit_store_path(@store)
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe '商品削除機能' do
    before do
      @store = FactoryBot.create(:store)
      @profile = FactoryBot.create(:profile, user_id: @store.user_id)
      FactoryBot.create_list(:store, 3, user_id: @store.user_id)
    end

    it '出品者だけが商品情報を削除でき削除後マイページに遷移すること' do
      sign_in(@store.user)
      visit store_path(@store)
      expect { click_on('削除する') }.to change { Store.count }.by(-1)
      expect(current_path).to eq user_path(@store.user)
    end

    it 'ユーザーアカウントが削除されるとそれに紐づく店舗情報も削除されること' do
      sign_in(@store.user)
      visit user_path(@store.user)
      expect { click_on('アカウント削除') }.to change { Store.count }.by(-4)
      expect(current_path).to eq root_path
    end
  end
end
