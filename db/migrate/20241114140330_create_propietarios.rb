class CreatePropietarios < ActiveRecord::Migration[7.0]
  def change
    create_table :propietarios do |t|
      t.string :nombre
      t.string :direccion
      t.string :contacto
      t.references :polideportivos, null: false, foreign_key: true

      t.timestamps
    end
  end
end
