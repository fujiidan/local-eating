class UsersController < ApplicationController
  def show
    @stores = Store.includes(:user).order("created_at DESC")
    @profile = current_user.profile
    gon.stores = @stores
    gon.profile = @profile
  end

  def edit

  end
  
  def update
  end
  
  def destroy
    current_user.destroy
    redirect_to root_path
  end
  
  private

end
