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
      if @polideportivo.save
        redirect_to administrador_polideportivos_path, notice: 'Polideportivo creado exitosamente.'
      else
        render :new
      end
    end

    # GET /administrador/polideportivos/:id/edit
    def edit
    end
S
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
