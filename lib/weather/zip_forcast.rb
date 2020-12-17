module Weather
  class ZipForcast
    attr_reader :high, :low, :average, :zip, :hourly_forcasts

    def initialize(result, zip)
      @zip = zip
      @average = 0
      @temperatures = []
      @hourly_forcasts = result["hourly"]
      parse_forcast_response
      calculate_average
      calcualte_high
      calcualte_low
    end

    private
    def parse_forcast_response
      hourly_forcasts.each do |hour_forcast|
        @temperatures.push(hour_forcast["temp"])
      end
    end

    def calculate_average
      @average = @temperatures.sum / hourly_forcasts.length
    end

    def calcualte_low
      @low = @temperatures.min
    end

    def calcualte_high
      @high = @temperatures.max
    end
  end
end
