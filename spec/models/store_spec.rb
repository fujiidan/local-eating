require 'rails_helper'

RSpec.describe Store, type: :model do
  describe '店舗登録' do
    before do
      @store = FactoryBot.build(:store)
    end

    context '店舗登録できるとき' do
      it '全ての情報を適切に入力すれば店舗登録できること' do
        expect(@store).to be_valid
      end

      it 'URLが無くても店舗登録できること' do
        @store.url = nil
        expect(@store).to be_valid
      end

      it '画像が無くても店舗登録できること' do
        @store.store_images = nil
        expect(@store).to be_valid
      end
    end

    context '店舗登録できないとき' do
      it '店舗名が必須であること' do
        @store.name = nil
        @store.valid?
        expect(@store.errors.full_messages).to include('店舗名を入力してください')
      end

      it '店舗名は２０文字以内であること' do
        @store.name = 'a' * 21
        @store.valid?
        expect(@store.errors.full_messages).to include('店舗名は20文字以内で入力してください')
      end

      it '住所が必須であること' do
        @store.address = nil
        @store.valid?
        expect(@store.errors.full_messages).to include('住所を入力してください')
      end

      it 'urlはhttpかhttpsを含んでいないと登録できないこと' do
        @store.url = 'www.hoge.com'
        @store.valid?
        expect(@store.errors.full_messages).to include('URLにはhttpまたはhttpsを含む必要があります')
      end

      it '緯度の算出には住所が必須であること' do
        @store.address = nil
        @store.valid?
        expect(@store.errors.full_messages).to include('緯度が算出されません、適切な住所を入力してください')
      end

      it '緯度の算出には住所が必須であること' do
        @store.address = nil
        @store.valid?
        expect(@store.errors.full_messages).to include('経度が算出されません、適切な住所を入力してください')
      end

      it 'ジャンルが必須であること' do
        @store.genre_id = nil
        @store.valid?
        expect(@store.errors.full_messages).to include('ジャンルを選択してください')
      end

      it '価格帯が必須であること' do
        @store.price_id = nil
        @store.valid?
        expect(@store.errors.full_messages).to include('価格帯を選択してください')
      end

      it '店舗情報が必須であること' do
        @store.info = nil
        @store.valid?
        expect(@store.errors.full_messages).to include('店舗情報を入力してください')
      end

      it '店舗情報は４００文字以内であること' do
        @store.info = 'a' * 401
        @store.valid?
        expect(@store.errors.full_messages).to include('店舗情報は400文字以内で入力してください')
      end

      it '画像の拡張子は.jpeg, .jpg, .gif, .png,以外では登録できないこと' do
        @store.store_images = nil
        file = fixture_file_upload('/files/test.bmp', 'image/bmp')
        @store.store_images.attach(file)
        @store.valid?
        expect(@store.errors.full_messages).to include('画像のContent Typeが不正です')
      end

      it '画像は11枚以上一度に保存できないこと' do
        @store.store_images = nil
        file = fixture_file_upload('/files/test.png', 'image/png')
        11.times do
          @store.store_images.attach(file)
        end
        @store.valid?
        expect(@store.errors.full_messages).to include('画像の数が許容範囲外です')
      end
    end
  end
end
