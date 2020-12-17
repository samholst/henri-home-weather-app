module Weather
  class ZipForecast
    attr_reader :high, :low, :average, :zip, :hourly_forecasts, :current_temp

    def initialize(result, zip)
      @zip = zip
      @average = 0
      @temperatures = []
      @hourly_forecasts = result["hourly"]
      @current_temp = result["current"]["temp"]
      parse_temperatures
      calculate_average
      calculate_high
      calculate_low
    end

    private

    def parse_temperatures
      hourly_forecasts.each do |hour_forecast|
        @temperatures.push(hour_forecast["temp"])
      end
    end

    def calculate_average
      @average = @temperatures.sum / hourly_forecasts.length
    end

    def calculate_low
      @low = @temperatures.min
    end

    def calculate_high
      @high = @temperatures.max
    end
  end
end
