class ResultCar
  def initialize(data, user_data, results_car)
    @data = data
    @user_data = user_data
    @results_car = results_car
  end

  def call
    @data.each do |car|
      if @user_data[:make] == car[:make].upcase ||
        @user_data[:make] == 0
        if @user_data[:model] == car[:model].upcase ||
          @user_data[:model] == 0
          if car[:year].between?(@user_data[:year_from], @user_data[:year_to]) ||
            car[:year] > @user_data[:year_from]
            if car[:price].between?(@user_data[:price_from], @user_data[:price_to]) ||
              car[:price] > @user_data[:price_from]
              @results_car.push(car)
            end
          end
        end
      end
    end
    @user_data[:results_car] = @results_car.size
    @results_car
  end
end
