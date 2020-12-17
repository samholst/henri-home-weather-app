class PagesController < ApplicationController
  def home
  end

  def search
    weather_forcast = Weather::Api.new(search_params[:zip])
    result = weather_forcast.get_result

    if result
      render json: { successful: true, forcast: result }
    else
      render json: { successful: false }
    end
  end

  private

  def search_params
    params.permit(:zip)
  end
end
