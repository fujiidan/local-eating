class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index
  before_action :check_guest, only: [:destroy, :update]
  before_action :set_profile, only: [:show, :favorite]


  def show
    @stores = Store.order('created_at DESC')
    @user_stores = current_user.stores.order('created_at DESC').page(params[:store_page]).per(10)
    @user_communities = current_user.communities.includes(:messages).order('created_at DESC').page(params[:community_page]).per(5)
    gon.stores = @stores
  end

  def favorite
    @like_stores = current_user.like_stores.page(params[:like_page]).per(10)
    @favorite_communities = current_user.favorite_communities.includes(:messages).page(params[:favorite_page]).per(10)
    gon.stores = @like_stores
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user), notice: 'ユーザー情報が更新されました'
    else
      render :edit
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_path, notice: 'ユーザーアカウントが削除されました'
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email)
  end

  def move_to_index
    @user = User.find(params[:id])
    redirect_to root_path if current_user.id != @user.id
  end

  def set_profile
    @profile = current_user.profile
    gon.profile = @profile
  end

  def check_guest
    if current_user.email == 'guest@gmail.com'
      redirect_to user_path(current_user), alert: 'ゲストユーザーの変更・削除はできません'
    end
  end
end
