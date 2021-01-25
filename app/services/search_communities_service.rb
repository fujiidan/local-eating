class SearchCommunitiesService

  def self.search(keyword)
    if keyword != ""
      Community.where('name LIKE(?)', "%#{keyword}%").order("created_at DESC")
    end
  end    
end