class AddJtiToAlunos < ActiveRecord::Migration[8.1]
  def change
    add_column :alunos, :jti, :string, null: false
    add_index :alunos, :jti, unique: true
  end
end
