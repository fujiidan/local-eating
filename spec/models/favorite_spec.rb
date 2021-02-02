require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @community = FactoryBot.create(:community)
    @favorite = FactoryBot.build(:favorite, user_id: @user.id, community_id: @community.id)
  end

  describe 'お気に入り機能' do
    it 'お気に入りを保存するにはuser_idとcommunity_idが必須であること' do
      expect(@favorite).to be_valid
    end

    it '1人のユーザーは１つのコミュニティに対して、１つしかお気に入りをつけれないこと' do
      @favorite.save
      another_favorite = FactoryBot.build(:favorite, user_id: @user.id, community_id: @community.id)
      another_favorite.valid?
      expect(another_favorite.errors.full_messages).to include('Userはすでに存在します')
    end
  end
end
