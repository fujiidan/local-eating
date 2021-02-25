class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index

  def edit
  end

  def update
    if current_user.profile.update(profile_params)
      redirect_to user_path(current_user), notice: 'プロフィール情報が更新されました'
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:address, :age, :sex_id, :latitude, :longitude, :profile_image)
  end

  def move_to_index
    @profile = Profile.find(params[:id])
    redirect_to root_path if current_user.id != @profile.user_id
  end
end
