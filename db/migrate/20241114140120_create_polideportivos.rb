class CreatePolideportivos < ActiveRecord::Migration[7.0]
  def change
    create_table :polideportivos do |t|
      t.string :nombre
      t.string :ubicacion
  
      
      t.string :contacto

      t.timestamps
    end
  end
end
