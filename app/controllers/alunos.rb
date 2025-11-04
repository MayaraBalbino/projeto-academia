class Alunos::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    # Login bem-sucedido
    render json: {
      status: { code: 200, message: 'Login com sucesso.' },
      data: { id: resource.id, email: resource.email, nome: resource.nome }
    }, status: :ok
  end

  def respond_to_on_destroy
    # Logout bem-sucedido
    if request.headers['Authorization'].present?
      render json: {
        status: 200,
        message: "Logout com sucesso."
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Não foi possível encontrar uma sessão ativa."
      }, status: :unauthorized
    end
  end
end