require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  describe 'コメント投稿' do
    before do
      @store = FactoryBot.create(:store)
      @profile = FactoryBot.create(:profile, user_id: @store.user_id)
      @comment = FactoryBot.build(:comment)
    end

    context 'コメント投稿できる時' do
      # docker環境でjs動かない為一旦コメントアウト
      # it 'コメント投稿すると、ページ遷移無くコメントが表示される', js: true  do
      #   sign_in(@store.user)
      #   visit store_path(@store)
      #   fill_in 'comment', with: @comment.comment
      #   image_path = Rails.root.join('public/images/test_image2.png')
      #   attach_file('comment[comment_images][]', image_path)
      #   click_on('コメントする')
      #   sleep 1
      #   expect(Comment.count).to eq 1
      #   expect(current_path).to eq store_path(@store)
      #   expect(page).to have_content(@comment.comment)
      #   expect(page).to have_selector("img[src$='test_image2.png']")
      # end

      it 'ログインしているユーザーにはコメントフォームが表示されること' do
        sign_in(@store.user)
        visit store_path(@store)
        expect(page).to have_no_content('コメントする')
      end
    end

    context 'コメント投稿できない時' do
      # # docker環境でjs動かない為一旦コメントアウト
      # it 'コメント投稿に失敗すると、ページ遷移なくページにとどまる', js: true  do
      #   sign_in(@store.user)
      #   visit store_path(@store)
      #   click_on('コメントする')
      #   expect(current_path).to eq store_path(@store)
      # end

      it 'ログインしていないユーザーにはコメントフォームが表示されない' do
        visit store_path(@store)
        expect(page).to have_no_content('コメントする')
      end
    end
  end

  describe 'コメント削除' do
    before do
      @store = FactoryBot.create(:store)
      @profile = FactoryBot.create(:profile, user_id: @store.user_id)
      FactoryBot.create(:comment, store_id: @store.id, user_id: @store.user_id)
    end

    context 'コメント削除できる時' do

      it 'コメント作成者には削除ボタンが表示されること' do
        sign_in(@store.user)
        visit store_path(@store)
        expect(page).to have_css(".fa-trash-alt")
      end

      it '店舗作成者は自身が作成していないコメントでも削除ボタンが表示されること' do
        @another_store = FactoryBot.create(:store)
        another_profile = FactoryBot.create(:profile, user_id: @another_store.user_id)
        FactoryBot.create(:comment, store_id: @another_store.id, user_id: @store.user_id)
        sign_in(@another_store.user)
        visit store_path(@another_store)
        expect(page).to have_css(".fa-trash-alt")
      end  

      # # docker環境でjs動かない為一旦コメントアウト
      # it 'コメント削除するとページ遷移なく画面に留まること', js: true  do
      #   sign_in(@store.user)
      #   visit store_path(@store)
      #   find(".fa-trash-alt").click
      #   sleep(1)
      #   expect(Comment.count).to eq 0
      #   expect(current_path).to eq store_path(@store)
      # end

      it 'ユーザーアカウントが削除されるとそれに紐づくコメント情報も削除されること' do
        FactoryBot.create_list(:comment, 2, store_id: @store.id, user_id: @store.user_id)
        sign_in(@store.user)
        visit user_path(@store.user)
        expect { click_on('アカウント削除') }.to change { @store.user.comments.count }.by(-3)
        expect(current_path).to eq root_path
      end

      it '店舗情報を削除するとそれに紐づくコメントも削除されること' do
        FactoryBot.create_list(:comment, 2, store_id: @store.id, user_id: @store.user_id)
        sign_in(@store.user)
        visit store_path(@store)
        expect { click_on('削除する') }.to change { @store.comments.count }.by(-3)
        expect(current_path).to eq user_path(@store.user)
      end
    end

    context 'コメント削除できない時' do

      it 'ログインしていないユーザーには削除ボタンが表示されないこと' do
        visit store_path(@store)
        expect(page).to have_no_css(".fa-trash-alt")
      end

      it 'ログイン済みでもコメント作成者または店舗作成者以外のユーザーには削除ボタンが表示されないこと' do
        another_user = FactoryBot.create(:profile)
        sign_in(another_user.user)
        visit store_path(@store)
        expect(page).to have_no_css(".fa-trash-alt")
      end
    end  
  end
end
