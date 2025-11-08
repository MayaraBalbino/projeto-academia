class Aluno < ApplicationRecord
  belongs_to :plano, optional: false
  
  before_validation :clean_cpf
  
  validates :nome, :cpf, :email, presence: true
  validates :cpf, :email, uniqueness: true
  validates :cpf, length: { is: 11 }, format: { with: /\A\d{11}\z/, message: "deve conter apenas números" }
  validates :plano_id, presence: true

  has_many :pagamentos
  has_many :treinos

  private

  def clean_cpf
    self.cpf = cpf.to_s.gsub(/\D/, '') if cpf.present?
  end
end
