require_relative 'statistic'
require 'i18n'

class Printer
  def initialize(results_car, user_data, stat)
    @results_car = results_car
    @user_data = user_data
    @stat = stat
  end

  def results
    puts '----------------------------------'
    puts I18n.t(:results)
    @results_car.each do |car|
      car.each do |attribute_name, attribute_value|
        puts "#{attribute_name}: #{attribute_value}"
      end
      puts '----------------------------------'
    end
  end

  def stat
    puts '----------------------------------'
    puts I18n.t(:statistic)
    puts "#{I18n.t(:total_quantity)} #{@user_data[:total_qantity]}"
    puts "#{I18n.t(:requests_quantity)} #{Statistic.new(@user_data, @results_car, @stat).call}"
  end
end
