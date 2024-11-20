class ReservasController < ApplicationController
  before_action :set_polideportivo
  before_action :set_cancha
  require 'net/http'
  require 'uri'
  require 'json'

  def index
    @reservas = @cancha.reservas
  end

  def new
    fecha = params[:reserva]&.dig(:fecha).present? ? Date.parse(params[:reserva][:fecha]) : nil
    hora_inicio = params[:reserva]&.dig(:hora_inicio).present? ? Time.parse("1970-01-01 #{params[:reserva][:hora_inicio]}") : nil
    hora_fin = params[:reserva]&.dig(:hora_fin).present? ? Time.parse("1970-01-01 #{params[:reserva][:hora_fin]}") : nil
    @reserva = Reserva.new(fecha: fecha, hora_inicio: hora_inicio, hora_fin: hora_fin)
  end

  def create
    @reserva = @cancha.reservas.new(reserva_params)

    if @reserva.valid?
      render :payment, locals: { reserva: @reserva, precio: calcular_precio(@reserva) }
    else
      flash[:alert] = "Error en los datos de la reserva."
      render :new, status: :unprocessable_entity
    end
  end

  # Método para procesar el pago con Yape
  def create_payment
    logger.info "Entrando en create_payment con los siguientes parámetros: #{params.inspect}"

    # Validar parámetros
    phone_number = params[:phoneNumber]
    otp = params[:otp]
    email = params[:email]

    unless phone_number.present? && otp.present? && email.present?
      render json: { status: 'error', message: 'Datos incompletos. Verifica los campos requeridos.' }, status: :unprocessable_entity
      return
    end

    # Generar el token Yape
    yape_token = generate_yape_token(phone_number, otp)

    if yape_token
      # Realizar el proceso de pago con el token Yape generado
      sdk = Mercadopago::SDK.new(ENV['MERCADOPAGO_ACCESS_TOKEN'])
      precio_reserva = calcular_precio(reserva_params)

      payment_object = {
        token: yape_token,
        transaction_amount: precio_reserva,
        description: "Reserva de cancha: #{@cancha.nombre}",
        installments: 1,
        payment_method_id: "yape",
        payer: { email: email }
      }

      payment_response = sdk.payment.create(payment_object)

      if payment_response[:response]['status'] == 'approved'
        # Crear la reserva solo si el pago fue aprobado
        @reserva = @cancha.reservas.new(reserva_params)
        if @reserva.save
          render json: { status: 'approved', message: 'Pago aprobado y reserva confirmada.' }
        else
          render json: { status: 'error', message: 'Error al guardar la reserva.' }, status: :unprocessable_entity
        end
      else
        error_message = payment_response[:response]['status_detail'] || "Error desconocido"
        render json: { status: 'error', message: "Error al procesar el pago: #{error_message}" }, status: :unprocessable_entity
      end
    else
      render json: { status: 'error', message: 'No se pudo generar el token Yape.' }, status: :unprocessable_entity
    end
  end

  private

  # Método para generar el token Yape
  def generate_yape_token(phone_number, otp)
    url = URI("https://api.mercadopago.com/platforms/pci/yape/v1/payment")

    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{ENV['MERCADOPAGO_ACCESS_TOKEN']}"
    }

    body = {
      phoneNumber: phone_number,
      otp: otp,
      requestId: SecureRandom.uuid
    }

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url, headers)
    request.body = body.to_json

    response = http.request(request)

    if response.code.to_i == 200
      JSON.parse(response.body)["id"]
    else
      error_message = JSON.parse(response.body)["message"] rescue "Error desconocido"
      logger.error "Error al generar el token Yape: #{error_message}"
      nil
    end
  end

  # Calcula el precio basado en la hora de inicio
  def calcular_precio(reserva)
    hora_inicio = reserva[:hora_inicio] || Time.now
    if hora_inicio.hour >= 6 && hora_inicio.hour < 18
      @cancha.precio_dia
    else
      @cancha.precio_noche
    end
  end

  # Setea el polideportivo
  def set_polideportivo
    @polideportivo = Polideportivo.find_by(id: params[:polideportivo_id])
    redirect_to polideportivos_path, alert: "Polideportivo no encontrado." unless @polideportivo
  end

  # Setea la cancha
  def set_cancha
    @cancha = Cancha.find_by(id: params[:cancha_id])
    redirect_to polideportivo_canchas_path(@polideportivo), alert: "Cancha no encontrada." unless @cancha
  end

  # Parámetros permitidos para la reserva
  def reserva_params
    params.require(:reserva).permit(:nombre, :telefono, :email, :fecha, :hora_inicio, :hora_fin)
  end
end
