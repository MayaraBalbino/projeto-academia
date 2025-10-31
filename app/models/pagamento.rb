class Pagamento < ApplicationRecord
  belongs_to :aluno
  belongs_to :plano
end
