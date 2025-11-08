class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: :devise_controller?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :nome, :cpf, :telefone, :data_nascimento, :status, :plano_id
    ])

    devise_parameter_sanitizer.permit(:account_update, keys: [
      :nome, :telefone, :data_nascimento, :status
    ])
  end
end