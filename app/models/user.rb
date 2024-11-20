class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Relaciones con Admin y Propietario
  belongs_to :admin, optional: true
  belongs_to :propietario, optional: true
  has_many :polideportivos

  def entidad
    tipo == "Admin" ? admin : propietario
  end
end
