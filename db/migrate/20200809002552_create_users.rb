class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :auth_token, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.boolean :active, default: false
      t.string  :name
      t.timestamps
    end
  end
end
