class ProfilesController < ApplicationController
  
  def edit
  end
  
  def update
    if current_user.profile.update(profile_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end  

  private
  
  def profile_params
    params.require(:profile).permit(:address, :age, :sex_id, :latitude, :longitude)
  end  
end
