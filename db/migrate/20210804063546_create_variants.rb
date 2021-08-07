class CreateVariants < ActiveRecord::Migration[6.1]
  def change
    create_table :variants do |t|
      t.string :name
      t.references :make, null: false, foreign_key: true
      t.references :model, null: false, foreign_key: true
      t.references :year, null: false, foreign_key: true
      t.references :engine, null: false, foreign_key: true
      t.references :speed, null: false, foreign_key: true
      t.references :fuel, null: false, foreign_key: true
      t.references :door, null: false, foreign_key: true
      t.references :body_type, null: false, foreign_key: true
      t.references :drive_type, null: false, foreign_key: true
      t.references :transmission, null: false, foreign_key: true
      t.decimal :fuel_consumption, precision: 3, scale: 1
      t.decimal :safety_rating, precision: 2, scale: 1
      t.integer :weight
      t.decimal :displacement, precision: 2, scale: 1
      t.integer :power

      t.timestamps
    end
  end
end
