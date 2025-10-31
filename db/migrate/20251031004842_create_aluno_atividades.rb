class CreateAlunoAtividades < ActiveRecord::Migration[8.1]
  def change
    create_table :aluno_atividades do |t|
      t.references :aluno, null: false, foreign_key: true
      t.references :atividade_fisica, null: false, foreign_key: true
      t.date :data_inicio
      t.date :data_fim
      t.string :dias_semana

      t.timestamps
    end
  end
end
