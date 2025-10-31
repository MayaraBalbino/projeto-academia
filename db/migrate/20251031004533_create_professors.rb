class CreateProfessors < ActiveRecord::Migration[8.1]
  def change
    create_table :professors do |t|
      t.string :nome
      t.string :cpf
      t.string :telefone
      t.string :email
      t.string :especialidade
      t.date :data_contratacao
      t.decimal :salario

      t.timestamps
    end
  end
end
