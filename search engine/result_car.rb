# frozen_string_literal: true

class ResultCar
  def initialize(data, user_data, results_car)
    @data = data
    @user_data = user_data
    @results_car = results_car
  end

  def call
    @data.each do |car|
      next unless (@user_data[:make] == car[:make].upcase || @user_data[:make].nil?) &&
                  (@user_data[:model] == car[:model].upcase || @user_data[:model].nil?) &&
                  (car[:year].between?(@user_data[:year_from], @user_data[:year_to]) ||
                  (@user_data[:year_to].zero? && car[:year] >= @user_data[:year_from])) &&
                  (car[:price].between?(@user_data[:price_from], @user_data[:price_to]) ||
                  (@user_data[:price_to].zero? && car[:price] >= @user_data[:price_from]))

      @results_car.push(car)
    end
    @user_data[:total_qantity] = @results_car.size
    @results_car
  end
end
