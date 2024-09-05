class ApiController < ApplicationController
  def mostrar_datos
    api = ApiConsumer.new
    begin
      @datos = api.obtener_datos('/properties?page=1&limit=20')
      render json: @datos
    rescue ApiConsumer::ApiError => e
      render json: { error: e.message }, status: e.status
    rescue StandardError => e
      render json: { error: 'Internal Server Error' }, status: :internal_server_error
    end
  end
end