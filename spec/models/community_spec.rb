require 'rails_helper'

RSpec.describe Community, type: :model do
  before do
    @community = FactoryBot.build(:community)
  end

  describe 'コミュニティ作成' do
    it '全ての情報を適切に入力すればコミュニティを作成できること' do
      expect(@community).to be_valid
    end

    it '名前が無いとコミュニテイ作成できないこと' do
      @community.name = nil
      @community.valid?
      expect(@community.errors.full_messages).to include('名前を入力してください')
    end
  end
end
