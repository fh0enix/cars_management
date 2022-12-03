# frozen_string_literal: true

class ResultCar
  def initialize(data, user_data, results_car)
    @data = data
    @user_data = user_data
    @results_car = results_car
  end

  def call
    make_results_car
    @user_data[:total_qantity] = @results_car.size
    @results_car
  end

  private

  def check_make(car)
    @user_data[:make] == car[:make].upcase || @user_data[:make].nil?
  end

  def check_model(car)
    @user_data[:model] == car[:model].upcase || @user_data[:model].nil?
  end

  def check_year(car)
    (car[:year].between?(@user_data[:year_from], @user_data[:year_to]) ||
      (@user_data[:year_to].zero? && car[:year] >= @user_data[:year_from]))
  end

  def check_price(car)
    (car[:price].between?(@user_data[:price_from], @user_data[:price_to]) ||
      (@user_data[:price_to].zero? && car[:price] >= @user_data[:price_from]))
  end

  def make_results_car
    @data.each do |car|
      next unless check_make(car) && check_model(car) && check_year(car) && check_price(car)

      @results_car.push(car)
    end
  end
end
