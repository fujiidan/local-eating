class LikesController < ApplicationController
before_action :authenticate_user!
before_action :find_store

  def create
    Like.create(user_id: current_user.id, store_id: params[:store_id])
    respond_to do |format|
      format.js
    end  
  end
  
  def destroy
    Like.find_by(user_id: current_user.id, store_id: params[:store_id]).destroy
    respond_to do |format|
      format.js
    end  
  end

  private

  def find_store
    @store = Store.find(params[:store_id])
  end
  
end
