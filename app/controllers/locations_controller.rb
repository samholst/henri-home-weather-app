class LocationsController < ApplicationController
  def create
    location = Location.new(location_params)

    if location.save
      render json: { status: :created, location: location }
    else
      render json: { status: :unprocessable_entity }
    end
  end

  def destroy
    location = Location.find(location_params[:zip])

    if location.destroy
      render json: { status: :success }
    else
      render json: { status: :unprocessable_entity }
    end
  end

  private

  def location_params
    params.permit(:zip)
  end
end
