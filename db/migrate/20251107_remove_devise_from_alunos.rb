class RemoveDeviseFromAlunos < ActiveRecord::Migration[8.1]
  def change
    remove_index :alunos, :reset_password_token, if_exists: true
    remove_index :alunos, :jti, if_exists: true
    remove_column :alunos, :encrypted_password, if_exists: true
    remove_column :alunos, :reset_password_token, if_exists: true
    remove_column :alunos, :reset_password_sent_at, if_exists: true
    remove_column :alunos, :remember_created_at, if_exists: true
    remove_column :alunos, :jti, if_exists: true
  end
end
