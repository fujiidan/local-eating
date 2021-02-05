require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント投稿' do
    context 'コメント投稿できるとき' do
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
    end

    context 'コメント投稿できないとき' do
      it 'コメントか画像どちらかは必須であること' do
        @comment.comment = nil
        @comment.comment_images = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('コメントか画像は。どちらかは入力してください')
      end

      it 'コメントは200文字以内であること' do
        @comment.comment = 'a' * 201
        @comment.valid?
        expect(@comment.errors.full_messages).to include('コメントは200文字以内で入力してください')
      end

      it '画像の拡張子は.jpeg, .jpg, .gif, .png,以外では登録できないこと' do
        @comment.comment_images = nil
        file = fixture_file_upload('/files/test.bmp', 'image/bmp')
        @comment.comment_images.attach(file)
        @comment.valid?
        expect(@comment.errors.full_messages).to include('画像のContent Typeが不正です')
      end

      it '画像は7枚以上一度に保存できないこと' do
        @comment.comment_images = nil
        file = fixture_file_upload('/files/test.png', 'image/png')
        7.times do
          @comment.comment_images.attach(file)
        end
        @comment.valid?
        expect(@comment.errors.full_messages).to include('画像の数が許容範囲外です')
      end
    end
  end
end
