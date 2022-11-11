class Printer
  def initialize(results_car)
    @results_car = results_car
  end

  def results
    puts '----------------------------------'
    puts 'Results:'
    @results_car.each do |car|
      car.each do |key, value|
      puts "#{key}: #{value}"
    end
    puts '----------------------------------'
    end
  end
end
