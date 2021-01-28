class CommunitiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search]
  before_action :find_community, except: [:index, :search, :create]
  before_action :move_to_index, only: [:edit, :destroy]
  def index
    @community = Community.new
    @communities = Community.order('created_at DESC').page(params[:community_page]).per(10)
  end

  def search
    @search_communities = SearchCommunitiesService.search(params[:keyword])
    respond_to do |format|
      if @search_communities.present?
        format.js
      else
        format.html { render template: 'communities/index.html.erb' }
      end
    end
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

  def edit
  end

  def update
    if @community.update(community_params)
      redirect_to community_messages_path(@community)
    else
      render :edit
    end
  end

  def destroy
    @community.destroy
    redirect_to user_path(@community.user)
  end

  private

  def community_params
    params.require(:community).permit(:name).merge(user_id: current_user.id)
  end

  def find_community
    @community = Community.find(params[:id])
  end

  def move_to_index
    redirect_to root_path if current_user.id != @community.user_id
  end
end
