require 'rails_helper'

RSpec.describe 'Stores', type: :system do
  describe '店舗登録' do
    before do
      @store = FactoryBot.build(:store)
      @user = FactoryBot.create(:user)
    end

    # context '店舗登録できるとき' do
    #   it 'ログイン状態のユーザーのみが店舗登録ページに遷移でき、登録完了すると店舗詳細ページに遷移する' do
    #     create_store(@user, @store)
    #   end
    # end
    context '店舗登録できないとき' do
      it 'ログインしていないユーザーは、店舗登録ページを押すと、ログインページに遷移する' do
        visit root_path
        click_on('飲食店を追加する')
        expect(current_path).to eq new_user_session_path
      end

      it '店舗登録に失敗すると、商品登録ページに戻ってくる' do
        visit root_path
        sign_in(@user)
        click_on('飲食店を追加する')
        fill_in 'name', with: @store.name
        expect { click_on('店舗登録') }.to change { Store.count }.by(0)
        expect(current_path).to eq stores_path
      end
    end
  end
end
