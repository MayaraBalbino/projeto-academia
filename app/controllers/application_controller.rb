# Controller base da aplicação - todos os outros controllers herdam dele
class ApplicationController < ActionController::Base
  # Garante que todas as páginas exijam autenticação (login)
  before_action :authenticate_user!
end