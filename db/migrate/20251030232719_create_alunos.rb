class CreateAlunos < ActiveRecord::Migration[8.1]
  def change
    create_table :alunos do |t|
      t.string :nome, null: false
      t.string :cpf, null: false
      t.string :email, null: false
      t.string :telefone
      t.date :data_nascimento
      t.string :status, default: "ativo"
      t.references :plano, null: false, foreign_key: true

      t.timestamps
    end

    add_index :alunos, :cpf, unique: true
    add_index :alunos, :email, unique: true
  end
end
