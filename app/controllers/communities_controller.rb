class CommunitiesController < ApplicationController

  def index
    @community = Community.new
    @communities = Community.order('created_at DESC')
  end

  def create
    @community = Community.new(community_params)
    @communities = Community.order('created_at DESC')
    respond_to do |format|
      if @community.save
        format.js
      else 
        format.html { render template: 'communities/index.html.erb' }
      end
    end    
  end

  private

  def community_params
    params.require(:community).permit(:name).merge(user_id: current_user.id)
  end  
end
