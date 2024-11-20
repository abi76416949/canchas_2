module Administrador
  class DashboardsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin

    def index
      @polideportivos = Polideportivo.all
      @propietarios = Propietario.all
    end
  
  
    private
    def propietario_params
      params.require(:propietario).permit(:nombre, :direccion, :contacto, :polideportivo_id)
    end
    

    def authorize_admin
      redirect_to root_path, alert: "No tienes acceso a esta sección" unless current_user&.tipo == "Admin"
    end
  end
end
