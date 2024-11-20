class Polideportivo < ApplicationRecord
    has_many :propietarios
    has_one_attached :imagen
    has_many :canchas, dependent: :destroy
    belongs_to :user


  end
