require_relative 'statistic'

class Printer
  def initialize(results_car, user_data, stat)
    @results_car = results_car
    @user_data = user_data
    @stat = stat
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

  def stat
    puts '----------------------------------'
    puts 'Statistic:'
    puts "Total Quantity: #{@results_car.size}"
    puts "Requests quantity: #{Statistic.new(@user_data, @stat).call}"
  end
end
