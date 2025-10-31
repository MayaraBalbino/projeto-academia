class CreateTreinos < ActiveRecord::Migration[8.1]
  def change
    create_table :treinos do |t|
      t.references :aluno, null: false, foreign_key: true
      t.references :professor, null: false, foreign_key: true
      t.string :objetivo
      t.date :data_inicio
      t.date :data_fim
      t.text :observacoes

      t.timestamps
    end
  end
end
