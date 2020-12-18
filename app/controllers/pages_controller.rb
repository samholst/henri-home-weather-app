class PagesController < ApplicationController
  def home
    @locations = Location.all
  end

  def search
    weather_forecast = Weather::API.new(search_params[:zip])
    result = weather_forecast.get_result

    if result
      render json: { status: :created, forecast: result }
    else
      render json: { status: :unprocessable_entity }
    end
  end

  private

  def search_params
    params.permit(:zip)
  end
end
