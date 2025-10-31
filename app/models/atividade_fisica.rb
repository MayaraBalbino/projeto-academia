class AtividadeFisica < ApplicationRecord
  belongs_to :professor

  has_many :aluno_atividades
  has_many :alunos, through: :aluno_atividades
end
