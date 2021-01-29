require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @like = FactoryBot.build(:like)
  end

  describe 'いいね機能' do
    it 'いいねを保存するにはuser_idとstore_idが必須であること' do
      @like.save
      expect(@like.user_id).to eq 1
      expect(@like.store_id).to eq 1
    end
  end
end
