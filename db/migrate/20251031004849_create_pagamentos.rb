class CreatePagamentos < ActiveRecord::Migration[8.1]
  def change
    create_table :pagamentos do |t|
      t.references :aluno, null: false, foreign_key: true
      t.references :plano, null: false, foreign_key: true
      t.date :data_pagamento
      t.date :data_vencimento
      t.decimal :valor
      t.string :forma_pagamento
      t.string :referente_a
      t.string :status

      t.timestamps
    end
  end
end
