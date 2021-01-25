class CommunitiesController < ApplicationController

  def index
    @communities = Community.order('created_at DESC')
  end  
end
