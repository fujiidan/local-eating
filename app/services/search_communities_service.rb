class SearchCommunitiesService
  def self.search(keyword)
    Community.where('name LIKE(?)', "%#{keyword}%").order('created_at DESC') if keyword != ''
  end
end
