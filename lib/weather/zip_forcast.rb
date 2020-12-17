module Weather
  class ZipForcast
    attr_reader :high, :low, :average, :zip, :hourly_forcasts, :current_temp

    def initialize(result, zip)
      @zip = zip
      @average = 0
      @temperatures = []
      @hourly_forcasts = result["hourly"]
      @current_temp = result["current"]["temp"]
      parse_temperatures
      calculate_average
      calculate_high
      calculate_low
    end

    private

    def parse_temperatures
      hourly_forcasts.each do |hour_forcast|
        @temperatures.push(hour_forcast["temp"])
      end
    end

    def calculate_average
      @average = @temperatures.sum / hourly_forcasts.length
    end

    def calculate_low
      @low = @temperatures.min
    end

    def calculate_high
      @high = @temperatures.max
    end
  end
end
