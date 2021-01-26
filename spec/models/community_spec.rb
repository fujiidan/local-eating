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

  # describe 'コミュニティ検索機能' do
  #   before do
  #     @communities = FactoryBot.create_list(:community, 3)
  #   end

  #   context "一致するデータが存在する場合"  do
    
  #     it "検索文字列に完全一致する配列を返すこと" do
  #       expect(SearchCommunitiesService.search("テストコミュニティ")).to include(@community)
  #     end

  #     it "検索文字列に部分一致する配列を返すこと" do
  #       expect(SearchCommunitiesService.search("テスト")).to include(@community)
  #     end

  #     it "created_at降順で配列を返すこと" do
  #       expect(Community.order("created_at DESC").map(&:id)).to eq [3,2,1]
  #     end
  #   end

  #   context "一致するデータが存在しない場合" do

  #     it "検索文字列が一致しない場合、空の配列を返すこと" do
  #       expect(SearchCommunitiesService.search("あああ")).to be_empty
  #     end
  #   end
  # end
end
