require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'メッセージ投稿' do
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

    it 'メッセージか画像どちらかは必須であること' do
      @message.message = nil
      @message.message_images = nil
      @message.valid?
      expect(@message.errors.full_messages).to include('メッセージか画像は。どちらかは入力してください')
    end
  end
end
