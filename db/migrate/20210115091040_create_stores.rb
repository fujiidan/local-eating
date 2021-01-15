class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string     :name, null:false, unique: true
      t.string     :address, null: false
      t.float      :latitude, null: false
      t.float      :longitude, null: false
      t.string     :url
      t.integer    :genre_id, null: false
      t.integer    :price_id, null: false
      t.string     :info, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
