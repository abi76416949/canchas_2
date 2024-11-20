module Administrador
  class PropietariosController < ApplicationController
    before_action :authenticate_user!
    before_action :set_propietario, only: [:show, :edit, :update, :destroy]

    # GET /administrador/propietarios
    def index
      @propietarios = Propietario.all
    end

    # GET /administrador/propietarios/new
    def new
      @propietario = Propietario.new
    end

    # POST /administrador/propietarios
    def create
      @propietario = Propietario.new(propietario_params)
      if @propietario.save
        redirect_to administrador_propietarios_path, notice: 'Propietario creado exitosamente.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    # GET /administrador/propietarios/:id/edit
    def edit
    end

    # PATCH/PUT /administrador/propietarios/:id
    def update
      if @propietario.update(propietario_params)
        redirect_to administrador_propietarios_path, notice: 'Propietario actualizado exitosamente.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /administrador/propietarios/:id
    def destroy
      @propietario.destroy
      redirect_to administrador_propietarios_path, notice: 'Propietario eliminado exitosamente.'
    end

    private

    def set_propietario
      @propietario = Propietario.find(params[:id])
    end

    def propietario_params
      params.require(:propietario).permit(:nombre, :direccion, :contacto, :polideportivo_id)
    end
  end
end
