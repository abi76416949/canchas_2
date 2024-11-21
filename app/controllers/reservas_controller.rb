class ReservasController < ApplicationController
  before_action :set_polideportivo
  before_action :set_cancha

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

    if @reserva.save
      flash[:notice] = "Reserva creada exitosamente."
      redirect_to polideportivo_cancha_reservas_path(@polideportivo, @cancha)
    else
      flash[:alert] = "Error en los datos de la reserva."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_polideportivo
    @polideportivo = Polideportivo.find(params[:polideportivo_id])
  end

  def set_cancha
    @cancha = @polideportivo.canchas.find(params[:cancha_id])
  end

  def reserva_params
    params.require(:reserva).permit(:nombre, :telefono, :email, :fecha, :hora_inicio, :hora_fin)
  end
end