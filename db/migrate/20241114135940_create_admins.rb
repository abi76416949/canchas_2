class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :nombre
      t.string :telefono

      t.timestamps
    end
  end
end
