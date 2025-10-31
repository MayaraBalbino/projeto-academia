class Aluno < ApplicationRecord
  belongs_to :plano

  has_many :aluno_atividades
  has_many :atividades_fisicas, through: :aluno_atividades
end
