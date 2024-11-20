# app/controllers/sessions_controller.rb
class SessionsController < Devise::SessionsController
    def create
      user = User.find_by(email: params[:user][:email])

      if user&.valid_password?(params[:user][:password])
        sign_in(user)
        # Aquí llamamos a la función 'after_sign_in_path_for' del ApplicationController
        redirect_to after_sign_in_path_for(user), notice: 'Inicio de sesión exitoso'
      else
        flash[:alert] = 'Email o contraseña incorrectos'
        render :new
      end
    end
    def destroy
        # Lógica adicional antes de cerrar sesión, si la necesitas
        flash[:notice] = "Has cerrado sesión correctamente. ¡Hasta pronto!"
        # Llama al método destroy de Devise para cerrar la sesión
        super
      end
  end
