class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @stores = Store.includes(:user).order("created_at DESC")
    @profile = @user.profile
    gon.stores = @stores
    gon.profile = @profile
  end

  def edit

  end
  
  def update
  
  end
  
  def destroy
    
  end
  
  private

end
