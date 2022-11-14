class Preprocessing
  def initialize(user_data)
    @result_data = user_data
  end

  def call
    puts 'Please select search rules.'
    print 'Please choose make: '
    @result_data[:make] = gets.strip.upcase

    print 'Please choose model: '
    @result_data[:model] = gets.strip.upcase

    print 'Please choose year_from: '
    @result_data[:year_from] = gets.to_i

    print 'Please choose year_to: '
    @result_data[:year_to] = gets.to_i

    print 'Please choose price_from: '
    @result_data[:price_from] = gets.to_i

    print 'Please choose price_to: '
    @result_data[:price_to] = gets.to_i

    print 'Please choose sort option (date_added|price): '
    @result_data[:sort_option] = gets.strip.downcase

    print 'Please choose sort direction(desc|asc): '
    @result_data[:sort_direction] = gets.strip.downcase

    @result_data
  end
end
