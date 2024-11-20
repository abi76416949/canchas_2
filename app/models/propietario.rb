class Propietario < ApplicationRecord
  belongs_to :polideportivo
  has_one :user

end
