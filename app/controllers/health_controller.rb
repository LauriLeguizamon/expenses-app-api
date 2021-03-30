class HealthController < ApplicationController
  def health
    render json: { status: 'OK' }, status: :ok
  end
end