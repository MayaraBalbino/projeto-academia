# Gerencia o perfil do usuário logado
class UsersController < ApplicationController
  before_action :authenticate_user!

  # Exibe página de perfil do usuário
  def profile
    @user = current_user
  end

  # Atualiza dados do perfil (email, senha opcional)
  def update_profile
    @user = current_user
    # Se senha estiver em branco, atualiza só email
    if user_params[:password].blank?
      user_params_without_password = user_params.except(:password, :password_confirmation)
      if @user.update(user_params_without_password)
        redirect_to profile_path, notice: 'Perfil atualizado com sucesso.'
      else
        render :profile, status: :unprocessable_entity
      end
    else
      # Atualiza email e senha
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
