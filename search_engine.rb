require 'yaml'

class SearchEngine

  def initialize
    # load data from YAML
    @data = YAML.safe_load_file('.db/db.yml', symbolize_names: true)

    # create hash for user ansver
    @user_data = {make: nil, model: nil, year_from: nil,  year_to: nil, price_from: nil, price_to: nil, sort_option: nil, sort_direction: nil}

    # create empty array for user result search
    @results_car = []
  end

  def search
    gets_ansver_from_user
    cleer_user_ansver_from_wrong_data
    create_searching_rules_result
    create_sorting_results
    print_results
  end

  # gets ansver from user
  def gets_ansver_from_user
    puts 'Please select search rules.'

    print 'Please choose make: '
    @user_data[:make] = gets.strip.upcase

    print 'Please choose model: '
    @user_data[:model] = gets.strip.upcase

    print 'Please choose year_from: '
    @user_data[:year_from] = gets.to_i

    print 'Please choose year_to: '
    @user_data[:year_to] = gets.to_i

    print 'Please choose price_from: '
    @user_data[:price_from] = gets.to_i

    print 'Please choose price_to: '
    @user_data[:price_to] = gets.to_i

    print 'Please choose sort option (date_added|price): '
    @user_data[:sort_option] = gets.strip.downcase

    print 'Please choose sort direction(desc|asc): '
    @user_data[:sort_direction] = gets.strip.downcase
  end

  # cleer user ansver from wrong data
  def cleer_user_ansver_from_wrong_data
    if @user_data[:year_to] < @user_data[:year_from] ||
      @user_data[:year_to] = 0
      @user_data[:year_to] = Time.new.year
    end

    if @user_data[:price_from] > @user_data[:price_to] ||
      @user_data[:price_to] == 0
      @user_data[:price_to] = 2**32
    end

    if @user_data[:sort_direction] != 'asc'
      @user_data[:sort_direction] = 'desc'
    end

    if @user_data[:sort_option] != 'price'
      @user_data[:sort_option] = 'date_added'
    end

    @make = []
    @model = []

    @data.each do |index|
      @make << index[:make].upcase
      @model << index[:model].upcase
    end

    if @make.include?(@user_data[:make]) == false
     @user_data[:make] = 0
    end

    if @model.include?(@user_data[:model]) == false
      @user_data[:model] = 0
    end
  end

  # create searching rules result
  def create_searching_rules_result
    @data.each do |index|
      make = [0, index[:make].upcase]
      model = [0, index[:model].upcase]
      if make.include?(@user_data[:make]) and
        model.include?(@user_data[:model]) and
        index[:year].between?(@user_data[:year_from], @user_data[:year_to]) and
        index[:price].between?(@user_data[:price_from], @user_data[:price_to])
        @results_car.push(index)
      end
    end
  end

  # create sorting results
  def create_sorting_results
    if @user_data[:sort_option] == 'price'
     @results_car.sort_by!{ |k| k[:price]}
    else
      @results_car.sort_by!{ |k| k[:date_added]}
    end

    if @user_data[:sort_direction] == 'asc'
       @results_car.reverse!
     end
  end

  # print results
  def print_results
    puts '----------------------------------'
    puts 'Results:'
    @results_car.each do |index|
      index.each do |key, value|
        puts "#{key}: #{value}"
      end
      puts '----------------------------------'
    end
  end
end
