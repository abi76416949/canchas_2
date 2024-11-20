class PolideportivosController < ApplicationController
  def index
    @polideportivos = Polideportivo.all
  end
end
