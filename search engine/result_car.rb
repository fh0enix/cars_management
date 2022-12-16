# frozen_string_literal: true

class ResultCar
  def initialize(data, input_data, results_car)
    @data = data
    @input_data = input_data
    @results_car = results_car
  end

  def call
    make_results_car
    @input_data[:total_qantity] = @results_car.size
    @results_car
  end

  private

  def check_make(car)
    @input_data[:make] == car[:make].upcase || @input_data[:make].nil?
  end

  def check_model(car)
    @input_data[:model] == car[:model].upcase || @input_data[:model].nil?
  end

  def check_year(car)
    (car[:year].between?(@input_data[:year_from], @input_data[:year_to]) ||
      (@input_data[:year_to].zero? && car[:year] >= @input_data[:year_from]))
  end

  def check_price(car)
    (car[:price].between?(@input_data[:price_from], @input_data[:price_to]) ||
      (@input_data[:price_to].zero? && car[:price] >= @input_data[:price_from]))
  end

  def make_results_car
    @data.each do |car|
      next unless check_make(car) && check_model(car) && check_year(car) && check_price(car)

      @results_car.push(car)
    end
  end
end
