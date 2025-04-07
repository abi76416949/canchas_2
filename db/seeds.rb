# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Crea un usuario administrador por defecto si no existe
 # Crear el modelo Admin si usás la relación
 require "open-uri"

admin = Admin.find_or_create_by!(nombre: "Admin Principal", telefono: "999999999")

admin_user = User.find_or_create_by!(email: "admin@example.com") do |user|
  user.password = "123456"
  user.password_confirmation = "123456"
  user.tipo = "admin"
  user.admin_id = admin.id
end

puts "✅ Admin creado: admin@example.com / contraseña: 123456"

polideportivos_data = [
  {
    nombre: "Polideportivo Central",
    ubicacion: "Av. Principal 123",
    contacto: "987654321",
    imagen_path: "app/assets/images/polideportivos/image_1.jpg"
  },
  {
    nombre: "Polideportivo Norte",
    ubicacion: "Calle 8 - Los Olivos",
    contacto: "912345678",
    imagen_path: "app/assets/images/polideportivos/image_2.jpg"
  },
  {
    nombre: "Polideportivo Sur",
    ubicacion: "Av. Surco 789",
    contacto: "900112233",
    imagen_path: "app/assets/images/polideportivos/image_3.jpg"
  }
]

polideportivos_data.each do |data|
  polideportivo = Polideportivo.find_or_initialize_by(nombre: data[:nombre])
  polideportivo.ubicacion = data[:ubicacion]
  polideportivo.contacto = data[:contacto]
  polideportivo.user = admin_user

  image_file = File.open(Rails.root.join(data[:imagen_path]))
  polideportivo.imagen.attach(io: image_file, filename: "#{data[:nombre].parameterize}.jpg", content_type: 'image/jpeg')

  polideportivo.save!
end
