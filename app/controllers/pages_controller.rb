class PagesController < ApplicationController
  def home
    @locations = Location.all
  end

  def search
    weather_forcast = Weather::Api.new(search_params[:zip])
    result = weather_forcast.get_result

    if result
      render json: { status: :created, forcast: result }
    else
      render json: { status: :unprocessable_entity }
    end
  end

  private

  def search_params
    params.permit(:zip)
  end
end
