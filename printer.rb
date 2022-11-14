class Printer
  def initialize(results_car)
    @results_car = results_car
  end

  def results
    puts '----------------------------------'
    puts 'Results:'
    @results_car.each do |car|
      car.each do |attribute_name, attribute_value|
        puts "#{attribute_name}: #{attribute_value}"
      end
      puts '----------------------------------'
    end
  end
end
