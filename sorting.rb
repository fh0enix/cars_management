class Sorting
  attr_reader :results_car

  def initialize(user_data, results_car)
    @user_data = user_data
	@results_car = results_car

    if @user_data[:sort_option] == 'price'
     @results_car.sort_by!{ |k| k[:price]}
    else
      @results_car.sort_by!{ |k| k[:date_added]}
    end

    if @user_data[:sort_direction] == 'asc'
       @results_car.reverse!
    end
  end
end
