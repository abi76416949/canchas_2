# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
    def new
      @propietario = Propietario.new
      super
    end
  
    def create
      @propietario = Propietario.new(propietario_params)
      build_resource(user_params)
  
      resource.propietario = @propietario
      resource.tipo = "Propietario"
  
      if resource.save && @propietario.save
        yield resource if block_given?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end
  
    private
  
    def propietario_params
      params.require(:propietario).permit(:nombre, :direccion, :contacto, :polideportivo_id)
    end
  
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end