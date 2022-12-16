# frozen_string_literal: true

class Sorting
  SORT_BY_PRICE_OPTION = 1
  SORT_ASC_OPTION = 1

  def initialize(input_data, results_car)
    @input_data = input_data
    @results_car = results_car
  end

  def call
    if @input_data[:sort_option] == SORT_BY_PRICE_OPTION
      @results_car.sort_by! { |k| k[:price] }
    else
      @results_car.sort_by! { |k| k[:date_added] }
    end
    @results_car.reverse! if @input_data[:sort_direction] == SORT_ASC_OPTION
  end
end
