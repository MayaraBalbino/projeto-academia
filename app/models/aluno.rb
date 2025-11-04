class Aluno < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self # <-- Adicione isso
  
  # Adicione esta linha (para a "lista negra" de tokens):
  include Devise::JWT::RevocationStrategies::JTIMatcher
  belongs_to :plano

  has_many :aluno_atividades
  has_many :atividades_fisicas, through: :aluno_atividades
end
