class CreateUserProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :user_providers do |t|
      t.integer :user_provider_app_id
      t.integer :user_id
      t.string :openid
      t.string :nick_name
      t.string :phone
      t.string :country
      t.string :verify_token
      t.text :extra
      t.timestamps

      t.index :user_id
      t.index :openid
      t.index :phone
      t.index :country
      t.index :verify_token
      t.index [:phone, :country]
    end
  end
end
