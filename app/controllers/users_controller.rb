class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = current_user
  end

  def update_profile
    @user = current_user
    if user_params[:password].blank?
      user_params_without_password = user_params.except(:password, :password_confirmation)
      if @user.update(user_params_without_password)
        redirect_to profile_path, notice: 'Perfil atualizado com sucesso.'
      else
        render :profile, status: :unprocessable_entity
      end
    else
      if @user.update(user_params)
        redirect_to profile_path, notice: 'Perfil atualizado com sucesso.'
      else
        render :profile, status: :unprocessable_entity
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:nome, :email, :password, :password_confirmation)
  end
end
