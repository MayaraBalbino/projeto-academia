class UpdateUsersForDevise < ActiveRecord::Migration[8.1]
  def change
    change_column_default :users, :email, from: nil, to: ""
    change_column_null :users, :email, false
    change_column_default :users, :encrypted_password, from: nil, to: ""
    change_column_null :users, :encrypted_password, false
    add_column :users, :reset_password_token, :string unless column_exists?(:users, :reset_password_token)
    add_column :users, :reset_password_sent_at, :datetime unless column_exists?(:users, :reset_password_sent_at)
    add_column :users, :remember_created_at, :datetime unless column_exists?(:users, :remember_created_at)
    add_index :users, :email, unique: true unless index_exists?(:users, :email, unique: true)
    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token, unique: true)
  end
end
