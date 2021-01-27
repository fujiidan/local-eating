class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index

  def show
    @stores = Store.includes(:user).order('created_at DESC')
    @user_stores = current_user.stores.order('created_at DESC')
    @user_communities = current_user.communities.includes(:messages).order('created_at DESC')
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

  def move_to_index
    @user = User.find(params[:id])
    redirect_to root_path if current_user.id != @user.id
  end
end
