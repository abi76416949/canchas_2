class CreateReservas < ActiveRecord::Migration[7.0]
  def change
    create_table :reservas do |t|
      t.string :nombre
      t.string :telefono
      t.string :email
      t.references :cancha, null: false, foreign_key: { on_delete: :cascade }
      t.date :fecha
      t.time :hora_inicio
      t.time :hora_fin

      t.timestamps
    end
  end
end
