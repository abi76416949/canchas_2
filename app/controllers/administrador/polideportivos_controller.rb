module Administrador
  class PolideportivosController < ApplicationController
    before_action :authenticate_user!
    before_action :set_polideportivo, only: [:edit, :update, :destroy]

    # GET /administrador/polideportivos
    def index
      @polideportivos = Polideportivo.all
    end

    # GET /administrador/polideportivos/new
    def new
      @polideportivo = Polideportivo.new
    end

    # POST /administrador/polideportivos
    def create
      @polideportivo = Polideportivo.new(polideportivo_params)
      @polideportivo.user = current_user

      if @polideportivo.save

        redirect_to administrador_polideportivos_path, notice: 'Polideportivo creado exitosamente.'
      else
        render :new, notice:'Hubo un error en crear el polideportivo '
        puts @polideportivo.errors.full_messages

      end
    end

    # GET /administrador/polideportivos/:id/edit
    def edit
    end

    # PATCH/PUT /administrador/polideportivos/:id
    def update
      if @polideportivo.update(polideportivo_params)

        redirect_to administrador_polideportivos_path, notice: 'Polideportivo actualizado exitosamente.'
      else
        render :edit
      end
    end

    # DELETE /administrador/polideportivos/:id
    def destroy
      @polideportivo.destroy
      redirect_to administrador_polideportivos_path, notice: 'Polideportivo eliminado.'
    end

    private

    def set_polideportivo
      @polideportivo = Polideportivo.find(params[:id])
    end

    def polideportivo_params
      params.require(:polideportivo).permit(:nombre, :ubicacion, :contacto, :imagen)
    end
  end
end
