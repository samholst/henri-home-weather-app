require 'net/http'

module Weather
  class Api
    BASE_URL = 'https://api.openweathermap.org/data/2.5/'
    ZIP_ENDPOINT = '/weather'
    FORCAST_ENDPOINT = '/onecall'
    APP_ID = 'cde0b64f65a24ac9a9c7d4d819cac2bb'

    def initialize(zip)
      @zip = zip
    end

    def get_result
      zip_response = fetch(build_zip_enpoint_url)

      if zip_response && zip_response["coord"]
        forcast_response = fetch(build_forcast_enpoint_url(zip_response["coord"]["lat"], zip_response["coord"]["lon"]))
        create_zip_forcast(forcast_response)
      else
        nil
      end
    end

    private

    def create_zip_forcast(forcast_response)
      if forcast_response
        ZipForcast.new(forcast_response, @zip)
      else
        nil
      end
    end

    def fetch(url)
      response = Net::HTTP.get_response(url)

      if response.is_a?(Net::HTTPSuccess)
        JSON.parse(response.body)
      else
        nil
      end
    end

    def build_zip_enpoint_url
      uri = URI(BASE_URL + ZIP_ENDPOINT)
      params = {
        zip: @zip,
        APPID: APP_ID
      }
      uri.query = URI.encode_www_form(params)

      uri
    end

    def build_forcast_enpoint_url(lat, lon)
      uri = URI(BASE_URL + FORCAST_ENDPOINT)
      params = {
        lat: lat,
        lon: lon,
        APPID: APP_ID
      }
      uri.query = URI.encode_www_form(params)

      uri
    end
  end
end
