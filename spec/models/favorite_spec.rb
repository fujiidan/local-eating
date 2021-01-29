require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @favorite = FactoryBot.build(:favorite)
  end

  describe 'お気に入り機能' do
    it 'お気に入りを保存するにはuser_idとcommunity_idが必須であること' do
      @favorite.save
      expect(@favorite.user_id).to eq 1
      expect(@favorite.community_id).to eq 1
    end
  end
end
