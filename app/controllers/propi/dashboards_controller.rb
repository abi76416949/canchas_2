module Propi
  class DashboardsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_propietario

    def index
      @propietario = current_user.propietario
      @polideportivo = @propietario.polideportivo if @propietario
    end

    def edit
      @propietario = current_user.propietario
    end

    def update
      @propietario = current_user.propietario
      if @propietario.update(propietario_params)
        redirect_to propi_dashboard_path, notice: "Datos actualizados correctamente."
      else
        render :edit, alert: "Error al actualizar los datos."
      end
    end

    private

    def propietario_params
      params.require(:propietario).permit(:nombre, :direccion, :contacto)
    end

    def authorize_propietario
      unless current_user&.tipo == "Propietario"
        redirect_to root_path, alert: "No tienes acceso a esta sección"
      end
    end
  end
end


    #email: propietario@example.com
    #password: password
