class Cancha < ApplicationRecord
  has_many :reservas, dependent: :destroy
  has_one_attached :imagen
  belongs_to :polideportivo
  TIPOS_CANCHA = [
    'con techo',
    'sin techo',
    'con tribuna',
    'sin tribuna',
    'grass sintetico',
    'sin grass sintetico'
  ].freeze

  validates :tipo, presence: true
  validate :validar_tipos

  private

  def validar_tipos
    return if tipo.blank?
    invalid_tipos = tipo - TIPOS_CANCHA
    if invalid_tipos.any?
      errors.add(:tipo, "contiene valores no permitidos: #{invalid_tipos.join(', ')}")
    end
  end
end
