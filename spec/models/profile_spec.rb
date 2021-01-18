require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'プロフィール登録' do
    before do
      @profile = FactoryBot.build(:profile)
    end

    it 'プロフィールを入力すると登録できる' do
      expect(@profile).to be_valid
    end

    it 'プロフィールを入力しなくても登録できる' do
      @profile.address = nil
      @profile.age = nil
      @profile.sex_id = nil
      expect(@profile).to be_valid
    end
  end
end
