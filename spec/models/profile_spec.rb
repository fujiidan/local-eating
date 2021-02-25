require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'プロフィール登録' do
    before do
      @profile = FactoryBot.build(:profile)
    end

    context 'プロフィール登録できるとき' do
      it 'プロフィールを入力すると登録できること' do
        expect(@profile).to be_valid
      end

      it '年齢がなくても登録できること' do
        @profile.age = nil
        expect(@profile).to be_valid
      end

      it '性別がなくても登録できること' do
        @profile.sex_id = nil
        expect(@profile).to be_valid
      end

      it 'プロフィール画像が無くても店舗登録できること' do
        @profile.profile_image = nil
        expect(@profile).to be_valid
      end
    end

    context 'プロフィール登録できないとき' do
      it '年齢は４文字以上は登録できないこと' do
        @profile.age = '1234'
        @profile.valid?
        expect(@profile.errors.full_messages).to include('年齢は3文字以内で入力してください')
      end

      it '住所が必須であること' do
        @profile.address = nil
        @profile.valid?
        expect(@profile.errors.full_messages).to include('住所を入力してください')
      end

      it '緯度の算出には住所が必須であること' do
        @profile.address = nil
        @profile.valid?
        expect(@profile.errors.full_messages).to include('緯度が算出されません、適切な住所を入力してください')
      end

      it '緯度の算出には住所が必須であること' do
        @profile.address = nil
        @profile.valid?
        expect(@profile.errors.full_messages).to include('経度が算出されません、適切な住所を入力してください')
      end

      it '画像の拡張子は.jpeg, .jpg, .png,以外では登録できないこと' do
        @profile.profile_image = nil
        file = fixture_file_upload('/files/test.bmp', 'image/bmp')
        @profile.profile_image.attach(file)
        @profile.valid?
        expect(@profile.errors.full_messages).to include('画像のContent Typeが不正です')
      end
    end
  end
end
