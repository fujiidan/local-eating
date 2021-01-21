class StoresController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search_map, :show]
  before_action :find_store, except: [:index, :search_map, :new, :create]
  before_action :move_to_index, only: [:edit, :destroy]

  def index
    @stores = Store.includes(:user)
    gon.stores = @stores
  end

  def search_map
    results = Geocoder.search(params[:address])
    @latlng = results.first.coordinates
    @address = params[:address]
    respond_to do |format|
      format.js
    end
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      redirect_to store_path(@store)
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @store.comments.includes(:user).order("created_at DESC")
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
      redirect_to store_path(@store)
    else
      render :edit
    end
  end

  def destroy
    @store.destroy
    redirect_to root_path
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
