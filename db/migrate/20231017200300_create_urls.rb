class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.references :user, null: false, foreign_key: true
      t.string :original_url
      t.string :slug
      t.datetime :expires_at
      t.integer :clicks, default: 0

      t.timestamps
    end
  end
end
