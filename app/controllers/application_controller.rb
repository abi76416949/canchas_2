# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?


    protected
    def after_sign_in_path_for(resource)
          puts "Tipo de usuario: #{resource.tipo}"
          
        if resource.tipo.downcase == "admin"
          administrador_dashboard_path
        elsif resource.tipo.downcase. == "Propietario"
          propi_dashboard_path

        else
          root_path
        end
      end
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:tipo])
      devise_parameter_sanitizer.permit(:account_update, keys: [:tipo])
    end
  end
