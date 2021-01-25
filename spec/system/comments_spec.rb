require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  describe 'コメント投稿' do
    before do
      @store = FactoryBot.create(:store)
      @comment = FactoryBot.build(:comment)
    end

    context 'コメント投稿できる時' do
      it 'コメント投稿すると、ページ遷移無くコメントが表示される' do
        sign_in(@store.user)
        visit store_path(@store)
        fill_in 'comment', with: @comment.comment
        image_path = Rails.root.join('public/images/test_image.png')
        attach_file('comment[comment_images][]', image_path)
        click_on('コメントする')
        sleep 1
        expect(Comment.count).to eq 1
        expect(current_path).to eq store_path(@store)
        expect(page).to have_content(@comment.comment)
        expect(page).to have_selector("img[src$='test_image.png']")
      end

      it 'ログインしているユーザーにはコメントフォームが表示される' do
        sign_in(@store.user)
        visit store_path(@store)
        expect(page).to have_no_content('コメントする')
      end
    end

    context 'コメント投できない時' do
      it 'コメント投稿に失敗すると、ページ遷移なくページにとどまる' do
        sign_in(@store.user)
        visit store_path(@store)
        click_on('コメントする')
        expect(current_path).to eq store_path(@store)
      end

      it 'ログインしていないユーザーはコメントフォームが表示されない' do
        visit store_path(@store)
        expect(page).to have_no_content('コメントする')
      end
    end
  end

  describe 'コメント削除' do
    before do
      @store = FactoryBot.create(:store)
      @profile = FactoryBot.create(:profile, user_id: @store.user.id)
      FactoryBot.create_list(:comment, 3, store_id: @store.id, user_id: @store.user.id)
    end

    it 'ユーザーアカウントが削除されるとそれに紐づくコメント情報も削除されること' do
      visit root_path
      sign_in(@store.user)
      click_on("#{@store.user.nickname}さんのマイページ")
      expect { click_on('アカウント削除') }.to change { Comment.count }.by(-3)
      expect(current_path).to eq root_path
    end

    it '店舗情報を削除するとそれに紐づくコメントも削除されること' do
      sign_in(@store.user)
      visit store_path(@store)
      expect { click_on('削除する') }.to change { @store.comments.count }.by(-3)
      expect(current_path).to eq root_path
    end
  end
end
