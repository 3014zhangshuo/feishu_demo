class CreateUserProviderApps < ActiveRecord::Migration[5.2]
  def change
    create_table :user_provider_apps do |t|
      t.integer :channel
      t.string :name
      t.string :app_id
      t.string :app_secret
      t.text :extra

      t.timestamps
    end
  end
end
