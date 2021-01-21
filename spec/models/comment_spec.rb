require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント投稿' do
    it '全ての情報を適切に入力すればコメント投稿できること' do
      expect(@comment).to be_valid
    end

    it '画像が無くてもコメントがあればコメント投稿できること' do
      @comment.comment_images = nil
      expect(@comment).to be_valid
    end

    it 'コメントが無くても画像があればコメント投稿できること' do
      @comment.comment = nil
      expect(@comment).to be_valid
    end

    it 'コメントか画像どちらかは必須であること' do
      @comment.comment = nil
      @comment.comment_images = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include("コメントか画像は。どちらかは入力してください")
    end
  end
end
