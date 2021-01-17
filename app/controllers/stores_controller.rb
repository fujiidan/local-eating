class StoresController < ApplicationController
  def index
  end

  def search_map
    results = Geocoder.search(params[:address])
    @latlng = results.first.coordinates
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
      redirect_to root_path
    else 
      render :new
    end
  end
  
  private

  def store_params
    params.require(:store).permit(
      :name, :address, :latitude, :longitude, :url, :genre_id, :price_id, :info, images: []
    ).merge(user_id: current_user.id)
  end  
end