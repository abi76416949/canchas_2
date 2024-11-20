module Administrador
  class ReservasController < ApplicationController
    before_action :authenticate_user!
    before_action :set_polideportivo
    before_action :set_cancha
    before_action :set_reserva, only: [:show, :edit, :update, :destroy]


    # Lista de reservas para la cancha
    def index
      @reservas = @cancha.reservas
    end

    # Mostrar detalles de una reserva específica
    def show
    end

    # Formulario para una nueva reserva
    def new
      @reserva = @cancha.reservas.build
    end

    # Crear una nueva reserva
    def create
      @reserva = @cancha.reservas.build(reserva_params)
      if @reserva.save
        redirect_to administrador_polideportivo_cancha_reservas_path(@polideportivo, @cancha), notice: 'Reserva creada exitosamente.'
      else
        flash.now[:alert] = 'No se pudo crear la reserva. Revisa los errores.'
        render :new
      end
    end

    # Formulario para editar una reserva existente
    def edit
    end

    # Actualizar una reserva existente
    def update
      if @reserva.update(reserva_params)
        redirect_to administrador_polideportivo_cancha_reservas_path(@polideportivo, @cancha), notice: 'Reserva actualizada con éxito.'
      else
        flash.now[:alert] = 'No se pudo actualizar la reserva. Revisa los errores.'
        render :edit
      end
    end

    # Eliminar una reserva
    def destroy
      @reserva.destroy
      redirect_to administrador_polideportivo_cancha_reservas_path(@polideportivo, @cancha), notice: 'Reserva eliminada exitosamente.'
    end

    private

    # Métodos privados para encontrar los recursos anidados
    def set_polideportivo
      @polideportivo = Polideportivo.find(params[:polideportivo_id])
    end

    def set_cancha
      @cancha = @polideportivo.canchas.find(params[:cancha_id])
    end

    def set_reserva
      @reserva = @cancha.reservas.find(params[:id])
    end

    # Filtro de parámetros permitidos para la reserva
    def reserva_params
      params.require(:reserva).permit(:nombre, :telefono, :email, :fecha, :hora_inicio, :hora_fin)
    end
  end
end
