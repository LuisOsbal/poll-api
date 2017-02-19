class CreateTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :tokens do |t|
      t.datetime :expires_at
      t.references :user
      t.string :token

      t.timestamps
    end
    add_foreign_key :tokens, :users
  end
end
