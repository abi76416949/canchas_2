module Propi
  class CanchasController < ApplicationController
    before_action :authenticate_user!
    before_action :set_polideportivo
    before_action :set_cancha, only: [:edit, :update, :destroy]

    # GET /propi/canchas
    def index
      @canchas = @polideportivo.canchas
    end

    # GET /propi/canchas/new
    def new
      @cancha = @polideportivo.canchas.build
    end

    # POST /propi/canchas
    def create
      @cancha = @polideportivo.canchas.build(cancha_params)
      if @cancha.save
        redirect_to propi_canchas_path, notice: 'Cancha creada exitosamente.'
      else
        flash.now[:alert] = 'No se pudo crear la cancha. Revisa los errores.'
        render :new
      end
    end

    # GET /propi/canchas/:id/edit
    def edit
    end

    # PATCH/PUT /propi/canchas/:id
    def update
      if @cancha.update(cancha_params)
        redirect_to propi_canchas_path, notice: 'Cancha actualizada exitosamente.'
      else
        flash.now[:alert] = 'No se pudo actualizar la cancha. Revisa los errores.'
        render :edit
      end
    end

    # DELETE /propi/canchas/:id
    def destroy
      @cancha.destroy
      redirect_to propi_canchas_path, notice: 'Cancha eliminada exitosamente.'
    end

    private

    # Encuentra el polideportivo asociado al propietario actual
    def set_polideportivo
      @propietario = current_user.propietario
      @polideportivo = @propietario.polideportivo
    end

    # Encuentra la cancha específica
    def set_cancha
      @cancha = @polideportivo.canchas.find(params[:id])
    end

    # Filtros de parámetros permitidos
    def cancha_params
      params.require(:cancha).permit(:nombre, :descripcion, :precio_dia, :precio_noche, :imagen, tipo: [])
    end
  end
end
