require 'rails_helper'

RSpec.describe Store, type: :model do
  describe '店舗登録' do
    before do
      @store = FactoryBot.build(:store)
    end

    it '全ての情報を適切に入力すれば店舗登録できること' do
      expect(@store).to be_valid
    end

    it 'URLが無くても店舗登録できること' do
      @store.url = nil
      expect(@store).to be_valid
    end

    it '画像が無くても店舗登録できること' do
      @store.images = nil
      expect(@store).to be_valid
    end

    it '店舗名が必須であること' do
      @store.name = nil
      @store.valid?
      expect(@store.errors.full_messages).to include('店舗名を入力してください')
    end

    it '住所が必須であること' do
      @store.address = nil
      @store.valid?
      expect(@store.errors.full_messages).to include('住所を入力してください')
    end

    # it '緯度が必須であること' do
    #   @store.latitude = nil
    #   @store.valid?
    #   expect(@store.errors.full_messages).to include('緯度が算出されません、適切な住所を入力してください')
    # end

    # it '緯度が必須であること' do
    #   @store.longitude = nil
    #   @store.valid?
    #   expect(@store.errors.full_messages).to include('経度が算出されません、適切な住所を入力してください')
    # end

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
  end
end
