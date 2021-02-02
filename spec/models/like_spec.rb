require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @store = FactoryBot.create(:store)
    @like = FactoryBot.build(:like, user_id: @user.id, store_id: @store.id)
  end

  describe 'いいね機能' do
    it 'いいねを保存するにはuser_idとstore_idが必須であること' do
      expect(@like).to be_valid
    end

    it '1人のユーザーは１つの店舗に対して、１つしかいいねをつけれないこと' do
      @like.save
      another_like = FactoryBot.build(:like, user_id: @user.id, store_id: @store.id)
      another_like.valid?
      expect(another_like.errors.full_messages).to include('Userはすでに存在します')
    end
  end
end
