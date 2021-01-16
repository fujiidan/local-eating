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
end
