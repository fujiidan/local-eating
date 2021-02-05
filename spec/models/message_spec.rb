require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'メッセージ投稿' do
    context 'メッセージ投稿できるとき' do
      it '全ての情報を適切に入力すればメッセージ投稿できること' do
        expect(@message).to be_valid
      end

      it '画像が無くてもメッセージがあればメッセージ投稿できること' do
        @message.message_images = nil
        expect(@message).to be_valid
      end

      it 'メッセージが無くても画像があればメッセージ投稿できること' do
        @message.message = nil
        expect(@message).to be_valid
      end
    end

    context 'メッセージ投稿できないとき' do
      it 'メッセージか画像どちらかは必須であること' do
        @message.message = nil
        @message.message_images = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('メッセージか画像は。どちらかは入力してください')
      end

      it 'メッセージは50文字以内であること' do
        @message.message = 'a' * 51
        @message.valid?
        expect(@message.errors.full_messages).to include('メッセージは50文字以内で入力してください')
      end

      it '画像の拡張子は.jpeg, .jpg, .gif, .png,以外では登録できないこと' do
        @message.message_images = nil
        file = fixture_file_upload('/files/test.bmp', 'image/bmp')
        @message.message_images.attach(file)
        @message.valid?
        expect(@message.errors.full_messages).to include('画像のContent Typeが不正です')
      end

      it '画像は9枚以上一度に保存できないこと' do
        @message.message_images = nil
        file = fixture_file_upload('/files/test.png', 'image/png')
        9.times do
          @message.message_images.attach(file)
        end
        @message.valid?
        expect(@message.errors.full_messages).to include('画像の数が許容範囲外です')
      end
    end
  end
end
