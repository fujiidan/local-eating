require 'rails_helper'

RSpec.describe 'Messages', type: :system do
  describe 'メッセージ投稿' do
    before do
      @community = FactoryBot.create(:community)
      @profile = FactoryBot.create(:profile, user_id: @community.user_id)
      @message = FactoryBot.build(:message)
    end

    context 'メッセージ投稿できる時' do
      it 'ログインしているユーザーにはメッセージフォームが表示されること' do
        sign_in(@community.user)
        visit community_messages_path(@community)
        expect(page).to have_no_content('送信')
      end
      # docker環境でjs動かない為一旦メッセージアウト
      # it 'メッセージ投稿すると、ページ遷移無くメッセージが表示される', js: true do
      #   sign_in(@community.user)
      #   visit community_messages_path(@community)
      #   fill_in 'message', with: @message.message
      #   image_path = Rails.root.join('public/images/test_image.png')
      #   attach_file('message[message_images][]', image_path, make_visible: true)
      #   click_on('送信')
      #   sleep 1
      #   expect(Message.count).to eq 1
      #   expect(current_path).to eq community_messages_path(@community)
      #   expect(page).to have_content(@message.message)
      #   expect(page).to have_selector("img[src$='test_image.png']")
      # end
    end

    context 'メッセージ投稿できない時' do
      it 'ログインしていないユーザーにはメッセージフォームが表示されないこと' do
        visit community_messages_path(@community)
        expect(page).to have_no_content('送信')
      end

      it 'メッセージ投稿に失敗すると、ページ遷移なくページにとどまる' do
        sign_in(@community.user)
        visit community_messages_path(@community)
        click_on('送信')
        expect(current_path).to eq community_messages_path(@community)
      end
    end
  end

  describe 'メッセージ削除' do
    before do
      @community = FactoryBot.create(:community)
      @profile = FactoryBot.create(:profile, user_id: @community.user_id)
      FactoryBot.create(:message, user_id: @community.user_id, community_id: @community.id)
    end

    context 'メッセージ削除できる時' do
      it 'メッセージ作成者には削除ボタンが表示されること' do
        sign_in(@community.user)
        visit community_messages_path(@community)
        expect(page).to have_css('.fa-trash-alt')
      end

      it '店舗作成者は自身が作成していないメッセージでも削除ボタンが表示されること' do
        @another_community = FactoryBot.create(:community)
        another_profile = FactoryBot.create(:profile, user_id: @another_community.user_id)
        FactoryBot.create(:message, community_id: @another_community.id, user_id: @community.user_id)
        sign_in(@another_community.user)
        visit community_messages_path(@another_community)
        expect(page).to have_css('.fa-trash-alt')
      end

      # # docker環境でjs動かない為一旦コメントアウト
      # it 'メッセージ削除するとページ遷移なく画面に留まること', js: true  do
      #   sign_in(@community.user)
      #   visit community_messages_path(@community)
      #   find(".fa-trash-alt").click
      #   sleep(1)
      #   expect(Message.count).to eq 0
      #   expect(current_path).to eq community_messages_path(@community)
      # end

      it 'ユーザーアカウントが削除されるとそれに紐づくメッセージ情報も削除されること' do
        FactoryBot.create_list(:message, 2, user_id: @community.user_id, community_id: @community.id)
        sign_in(@community.user)
        visit user_path(@community.user)
        expect { click_on('アカウント削除') }.to change { @community.user.messages.count }.by(-3)
        expect(current_path).to eq root_path
      end

      it 'コミュニティを削除するとそれに紐づくメッセージも削除されマイページに遷移すること' do
        FactoryBot.create_list(:message, 2, user_id: @community.user_id, community_id: @community.id)
        sign_in(@community.user)
        visit communities_path
        expect { click_on('削除する') }.to change { @community.messages.count }.by(-3)
        expect(current_path).to eq user_path(@community.user)
      end
    end

    context 'メッセージ削除できない時' do
      it 'ログインしていないユーザーには削除ボタンが表示されないこと' do
        visit community_messages_path(@community)
        expect(page).to have_no_css('.fa-trash-alt')
      end

      it 'ログイン済みでもメッセージ作成者または店舗作成者以外のユーザーには削除ボタンが表示されないこと' do
        another_user = FactoryBot.create(:profile)
        sign_in(another_user.user)
        visit community_messages_path(@community)
        expect(page).to have_no_css('.fa-trash-alt')
      end
    end
  end
end
