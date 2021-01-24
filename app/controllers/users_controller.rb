class UsersController < ApplicationController
  def show
    @stores = Store.includes(:user).order("created_at DESC")
    @user_stores = current_user.stores.order("created_at DESC")
    @profile = current_user.profile
    gon.stores = @stores
    gon.profile = @profile
  end

  def edit
  end
  
  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else 
      render :edit
    end   
  end
  
  def destroy
    current_user.destroy
    redirect_to root_path
  end
  
  private

  def user_params
    params.require(:user).permit(:nickname, :email)
  end  

end
