class ResultCar
  attr_reader :results_car

  def initialize(data, user_data)
    @data = data
    @user_data = user_data
    @results_car = []

    @data.each do |car|
      if @user_data[:make] == car[:make].upcase ||
        @user_data[:model] == car[:model].upcase ||
        car[:year].between?(@user_data[:year_from], @user_data[:year_to]) &&
        car[:price].between?(@user_data[:price_from], @user_data[:price_to])
        @results_car.push(car)
      end
    end
  end
end
