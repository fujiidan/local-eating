class CommunitiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search]
  before_action :find_community, except: [:index, :search, :create]
  before_action :move_to_index, only: [:edit, :destroy]

  def index
    @community = Community.new
    @communities = Community.includes(:messages).order('created_at DESC').page(params[:community_page]).per(10)
  end

  def search
    @search_communities = SearchCommunitiesService.search(params[:keyword])
    respond_to do |format|
      format.js
    end
  end

  def create
    @community = Community.new(community_params)
    respond_to do |format|
      if @community.save
        format.js
      else
        @communities = Community.includes(:messages).order('created_at DESC').page(params[:community_page]).per(10)
        format.html { render template: 'communities/index.html.erb' }
      end
    end
  end

  def edit
  end

  def update
    if @community.update(community_params)
      redirect_to community_messages_path(@community), notice: 'コミュニティ情報が更新されました'
    else
      render :edit
    end
  end

  def destroy
    @community.destroy
    redirect_to user_path(@community.user), notice: 'コミュニティが削除されました'
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
