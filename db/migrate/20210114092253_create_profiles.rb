class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string     :address, null: false
      t.float      :latitude, null: false
      t.float      :longitude, null: false
      t.integer    :age
      t.integer    :sex_id
      t.references :user, null:false, foreign_key: true
      t.timestamps
    end
  end
end
