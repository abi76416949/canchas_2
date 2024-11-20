class CreateCanchas < ActiveRecord::Migration[7.0]
  def change
    create_table :canchas do |t|
      t.string :nombre
      t.text :descripcion
      t.float :precio_dia
      t.float :precio_noche
      t.references :polideportivo, null: false, foreign_key: true
      t.text :tipo, array: true, default: [] # Campo tipo array

      t.timestamps
    end
  end
end
