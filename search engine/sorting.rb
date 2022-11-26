class Sorting
  SORT_ANSWER = 1
  def initialize(user_data, results_car)
    @user_data = user_data
    @results_car = results_car
  end

  def call
    if @user_data[:sort_option] == SORT_ANSWER
      @results_car.sort_by! { |k| k[:price] }
    else
      @results_car.sort_by! { |k| k[:date_added] }
    end

    @results_car.reverse! if @user_data[:sort_direction] == SORT_ANSWER
  end
end
