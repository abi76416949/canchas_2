# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Crea un usuario administrador por defecto si no existe
 # Crear el modelo Admin si usás la relación
 admin = Admin.find_or_create_by!(nombre: "Admin Principal", telefono: "999999999")

 User.find_or_create_by!(email: "admin@example.com") do |user|
    user.password = "123456"
    user.password_confirmation = "123456"
    user.tipo = "admin"
    user.admin_id = admin.id
  end
  
 
  
  puts "✅ Admin creado: admin@example.com / contraseña: 123456"
  