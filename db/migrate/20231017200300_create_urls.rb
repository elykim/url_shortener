class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.string :original_url
      t.string :short_url
      t.datetime :expires_at

      t.timestamps
    end
  end
end
