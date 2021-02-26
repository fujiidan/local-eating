class StoresController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search_map, :show]
  before_action :find_store, except: [:index, :show, :search_map, :new, :create]
  before_action :move_to_index, only: [:edit, :destroy]

  def index
    @stores = Store.all
    gon.stores = @stores
  end

  def search_map
    results = Geocoder.search(params[:address])
    respond_to do |format|
      if results.present?
        @latlng = results.first.coordinates
        @address = params[:address]
        format.js
      else
        format.html { render template: 'stores/index.html.erb' }
      end
    end
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      redirect_to store_path(@store), notice: '店舗登録が完了しました'
    else
      render :new
    end
  end

  def show
    @store = Store.with_attached_store_images.find(params[:id])
    @comment = Comment.new
    @comments = @store.comments.includes(:user, [user: :profile], [user: {profile: {profile_image_attachment: :blob}}])
                .with_attached_comment_images.order('created_at DESC')
    gon.store = @store
  end

  def edit
  end

  def update
    if params[:store][:store_image_ids]
      params[:store][:store_image_ids].each do |store_image_id|
        store_image = @store.store_images.find(store_image_id)
        store_image.purge
      end
    end
    if @store.update(store_params)
      redirect_to store_path(@store), notice: '店舗情報が更新されました'
    else
      render :edit
    end
  end

  def destroy
    @store.destroy
    redirect_to user_path(@store.user), notice: '店舗情報が削除されました'
  end

  private

  def store_params
    params.require(:store).permit(
      :name, :address, :latitude, :longitude, :url, :genre_id, :price_id, :info, store_images: []
    ).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to root_path if current_user.id != @store.user_id
  end

  def find_store
    @store = Store.find(params[:id])
  end
end
