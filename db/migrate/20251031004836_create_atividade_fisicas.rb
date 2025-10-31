class CreateAtividadeFisicas < ActiveRecord::Migration[8.1]
  def change
    create_table :atividade_fisicas do |t|
      t.string :nome_atividade
      t.text :descricao
      t.string :nivel_dificuldade
      t.integer :duracao_minutos
      t.integer :calorias_estimadas
      t.references :professor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
