
require 'mercadopago'


if ENV['MERCADOPAGO_ACCESS_TOKEN'].present?
  MercadoPagoClient = Mercadopago::SDK.new(ENV['MERCADOPAGO_ACCESS_TOKEN'])
else
  raise "MERCADOPAGO_ACCESS_TOKEN no está configurado correctamente"
end

# acceder a la variable es con MercadoPagoConfig[:access_token]
