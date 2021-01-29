class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_community

  def create
    Favorite.create(user_id: current_user.id, community_id: params[:community_id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    Favorite.find_by(user_id: current_user.id, community_id: params[:community_id]).destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def find_community
    @community = Community.find(params[:community_id])
  end

end
