class PagesController < ApplicationController
  def home
  end

  private

  def home_params
    params.permite(:zip_code)
  end
end
