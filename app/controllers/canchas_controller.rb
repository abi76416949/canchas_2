class CanchasController < ApplicationController
  before_action :set_polideportivo

  # GET /polideportivos/:polideportivo_id/canchas
  def index
    @canchas = @polideportivo.canchas
  end

  private

  def set_polideportivo
    @polideportivo = Polideportivo.find_by(id: params[:polideportivo_id])
    unless @polideportivo
      redirect_to polideportivos_path, alert: 'Polideportivo no encontrado'
    end
  end
end
