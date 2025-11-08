class Professor < ApplicationRecord
  validates :cpf, length: { is: 11 }, format: { with: /\A\d{11}\z/, message: "deve conter apenas números" }, allow_blank: true
end
