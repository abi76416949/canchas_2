module Administrador
  class CanchasController < ApplicationController
    before_action :authenticate_user!
    before_action :set_polideportivo
    def index
      @canchas = @polideportivo.canchas
    end
    def new
      @cancha = @polideportivo.canchas.build
    end

    def create
      @cancha = @polideportivo.canchas.build(cancha_params)
      if @cancha.save
        redirect_to administrador_polideportivo_canchas_path(@polideportivo), notice: 'Cancha creada exitosamente.'
      else
        puts @cancha.errors.full_messages # Añadir esto para ver los errores
        flash.now[:alert] = 'No se pudo crear la cancha. Revisa los errores.'
        render :new
      end
    end
    def destroy
      @cancha = @polideportivo.canchas.find(params[:id])
      @cancha.destroy
      redirect_to administrador_polideportivo_canchas_path(@polideportivo), notice: 'Cancha eliminada exitosamente.'
    end
    def edit
      @cancha = @polideportivo.canchas.find(params[:id])
    end
    def update
      @cancha = @polideportivo.canchas.find(params[:id])
      if @cancha.update(cancha_params)
        redirect_to administrador_polideportivo_canchas_path(@polideportivo), notice: 'Cancha actualizada exitosamente.'
      else
        flash.now[:alert] = 'No se pudo actualizar la cancha. Revisa los errores.'
        render :edit
      end
    end

    private

    def set_polideportivo
      @polideportivo = Polideportivo.find(params[:polideportivo_id])
    end

    def cancha_params
      params.require(:cancha).permit(:nombre, :descripcion, :precio_dia, :precio_noche, :imagen, tipo: [])
    end

  end
end
