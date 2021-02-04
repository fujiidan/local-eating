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
    end
    
    context 'プロフィール登録できないとき' do

      it '年齢は４文字以上は登録できないこと' do
        @profile.age = "1234"
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
    end  
  end
end
